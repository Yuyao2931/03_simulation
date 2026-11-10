birthday_repeated = function(n_room){
  
  birthday = sample(1:365, size = 5, replace = TRUE)
  
  repeated_birthdays = length(unique(birthday)) < n_room
  
  return(repeated_birthdays)
}
