function fish_greeting
  #fortune ~/.config/fortunes/CarlSagan/quotes | lolcat
  #cowsay (fortune) | lolcat
  shuf -n 1 ~/.config/cowsay/quotes.txt | cowsay | lolcat
end
