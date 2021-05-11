% switch Energy
%     case 0.1433
%         disp('Yellow Sigatoka')
%     case 0.2927
%         disp('Eumusea')
%     case 1
%         disp('positive one')
%     otherwise
%         disp('other value')
% end

Energy=Energy*1;
  if((Energy > 0.29)&&(Energy < 0.3))
    disp('Eumusea'); 
  elseif((Energy >0.143)&&(Energy < 0.144))
   disp('Yellow Sigatoka'); 
  elseif((Energy >0.200)&&(Energy < 0.201))
   disp('Black Sigatok'); 
else
    disp('Normal Leaf')
  end 
Energy
