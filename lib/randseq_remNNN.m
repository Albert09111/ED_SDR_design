function new_seq = randseq_remNNN(length)

new_seq = randseq(length);
   while ~isempty(strfind(new_seq,'AAA'))||~isempty(strfind(new_seq,'CCC'))||~isempty(strfind(new_seq,'TTT'))||~isempty(strfind(new_seq,'GGG')) % check if there is 1 in repeat, if there is, return 0
      new_seq = randseq(length);
   end
   new_seq = new_seq;
end