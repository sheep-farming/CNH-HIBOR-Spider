result=[];
fprintf('From:\n');
sYear =input('YYYY ');
sMonth =input('MM ');
sDay =input('DD ');
fprintf('To:\n');
tYear =input('YYYY ');
tMonth =input('MM ');
tDay =input('DD ');


cDate = datetime(sYear,sMonth,sDay);
while (cDate <= datetime(tYear,tMonth,tDay))
    strDate = [num2str(month(cDate)) '-' num2str(day(cDate))];
    cURL = 'http://www.tma.org.hk/en_market_more_ib.aspx?year=2016&month=';
    cURL = [cURL num2str(month(cDate)) '&day=' num2str(day(cDate))];
    strt=urlread(cURL);
    cReg = regexp(strt,'(?<=<td align="center" bgcolor="#FFFFFF" class="market_w11px">\s*)\S{7,8}(?=\s*</td>)','match');
    if (length(cReg)==8)
        dataEntry=[datenum(strDate)];
        for i=(1:8)
            k = cReg(i);
            k = str2num(k{1});
            dataEntry=[dataEntry k];
        end
        
    end
    result=[result;dataEntry];
    fprintf('%s\n',datestr(cDate));
    cDate=cDate+1;
    plot(result(:,1),result(:,2:9));
    pause(0.1);
end
dlmwrite('RESULT.csv', result(:,:),'delimiter', ',', 'precision', 9);
fprintf('All Done!\nResult saved to RESULT.csv');
