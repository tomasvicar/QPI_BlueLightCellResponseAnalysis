function x = replace_nans(x)
  x = [0 x]  ;                   % put a zero into the first position

  while any(isnan(x))           % loop until there is any NaN
    NaNList = isnan(x) ;         % get a logical list of NaNs
    NaNPos = min(find(NaNList)) ;% find the position of the first NaN
    x(NaNPos) = x(NaNPos - 1)  ; % new value: the value on the left
  end
  
  x(1) = []      ;               % remove the zero from the first position
end