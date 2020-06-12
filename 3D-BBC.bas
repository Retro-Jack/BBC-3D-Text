10 REM PROGRAM 3D TEXT
20 REM VERSION B0.2
30 :
40 ON ERROR GOTO 950
50 :
60 DIMline$(3)
70 MODE 1
80 VDU19,3,2;0;19,2,7;0;
90 PROCtext
100 FORI=1TO20000
110 NEXTI
120 MODE 7
130 END
140 :
150 DEF PROC3D
160 FOR L%=lines%-1 TO 0 STEP -1
170 ang%=alt%-(L%*mult%) 
180 PROCword(line$(L%+1),1008-(32*L%)) 
190 NEXT L%
200 ENDPROC
210 :
220 DEF PROCword(line$(L%),oy%) 
230 COLOUR2
240 PRINTTAB(20,31)line$(L%); 
250 FOR py%=1 TO 33 STEP4
260 angle%=(py%/height)+ang%
270 a1=TAN(RAD(angle%)):a2=TAN(RAD(angle%-change%))
280 sub=4:lp=1309:rp=1359
290 FOR px%=(LEN(line$(L%))+1)*32 TO 0 STEP-4
300 IF POINT(px%+640,py%)=2 PROCbox
310 rp=lp:sub=sub+add:lp=lp-sub 
320 NEXT px%
330 NEXT py% 
340 PRINTTAB(20,31) SPC(18);
350 ENDPROC
360 :
370 DEF PROCbox
380 PROCface(2,lp,rp,lp,rp,((1579-lp)*a2)+oy%,((1579-rp)*a2)+oy%,((1579-lp)*a1)+oy%,((1579-rp)*a1)+oy%)
390 PROCface(4,lp-sub,lp,lp-sub,lp,((1579-lp)*a2)+oy%+sub,((1579-lp)*a2)+oy%,((1579-lp)*a1)+oy%+sub,((1579-lp)*a1)+oy%)
400 PROCface(3,lp-sub,rp-sub,lp,rp,((1579-lp)*a1)+oy%+sub,((1579-rp)*a1)+oy%+sub,((1579-lp)*a1)+oy%,((1579-rp)*a1)+oy%)
410 ENDPROC
420 :
430 DEF PROCface(col%,x1,x2,x3,x4,y1,y2,y3,y4)
440 GCOL0,col%
450 PLOT4,x1,y1 
460 PLOT4,x2,y2
470 PLOT85,x3,y3
480 PLOT4,x2,y2
490 PLOT4,x4,y4
500 PLOT85,x3,y3
510 ENDPROC
520 :
530 DEF PROCprepare
540 RESTORE600
550 FOR L%=1 TO style%
560 READ height,mletters%,mlines%,add,change%,alt%,mult% 
570 NEXT
580 IF lines%>mlines% THEN CLS:PRINT "Too many lines for style ";style%:END
590 ENDPROC
600 DATA4,13,3,.13,1,-13,8 
610 DATA4,6,3,.65,1,-13,8
620 DATA1.95,13,2,.13,2,-16,15
630 DATA1.95,6,2,.65,2,-16,15
640 DATA1.33,13,1,.13,3,-29,8
650 DATA1.33,6,1,.65,3,-29,8
660 :
670 DEF PROCcentre
680 FOR L%=1 TO lines%
690 IF LEN(line$(L%))=mletters% GOTO710
700 line$(L%)=line$(L%)+STRING$((mletters%+1-LEN(line$(L%)))*.5," ") 
710 NEXT L%
720 ENDPROC
730 :
740 DEF PROCtext
750 VDU23,230,60,126,219,126,36,66,129,0 
760 REM  =========================
770 REM | Style | Lines | Letters |
780 REM |   1   |   3   |   13    |
790 REM |   2   |   3   |    6    |
800 REM |   3   |   2   |   13    |
810 REM |   4   |   2   |    6    |
820 REM |   5   |   1   |   13    |
830 REM |   6   |   1   |    6    |
840 REM  ========================= 
850 style%=1
860 lines%=3
870 line$(1)="The Lavian's"
880 line$(2)=CHR$230+" Boomer "+CHR$230
890 line$(3)="Game Zone"
900 PROCprepare
910 PROCcentre
920 PROC3D
930 ENDPROC
940 :
950 ON ERROR OFF
960 MODE 7
970 IF ERR<>17 THEN REPORT:PRINT " at line ";ERL
980 END