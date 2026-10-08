Warning: truncated output (original token count: 32811)
Total output lines: 3538

      PROGRAM GRANETO
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters IEEE AP Magazine June 2002, pp. 114 - 123
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
      DIMENSION CSR(3),CSMR(3)
      TR=ACOS(0.)/90.
      OPEN(66,FILE='granetoc.out')
      WRITE(6,60)
   60 FORMAT(' Enter example number (0 all) ',$)
      READ(5,*)IEX
C  ---------- Example 1
      IF(IEX.EQ.1.OR.IEX.EQ.0)THEN
C  ---------- Option 1
      DM=100.
      BETA=10.1
      SIG=-1
      WRITE(66,1)DM
    1 FORMAT(' Example 1. Cassegrain',/,
     1' Main reflector diameter DM:               ',F8.3)
      F=107.3
      H=79.4
      DSX=15.0
      WRITE(66,2)F,H,DSX,BETA
    2 FORMAT(/,' Design option 1',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO1(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,3)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
    3 FORMAT(/,' Outputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 2
      DM=100.
      BETA=10.1
      SIG=-1
      F=107.3
      H=79.4
      DLS=28.0096
      WRITE(66,4)F,H,DLS,BETA
    4 FORMAT(/,' Design option 2',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO2(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,5)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
    5 FORMAT(/,' Outputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 3
      DM=100.
      BETA=10.1
      SIG=-1
      F=107.3
      H=79.4
      DFMR=35.4959
      WRITE(66,6)F,H,DFMR,BETA
    6 FORMAT(/,' Design option 3',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO3(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,7)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
    7 FORMAT(/,' Outputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 4
      DM=100.
      BETA=10.1
      SIG=-1
      F=107.3
      H=79.4
      DLT=95.539
      WRITE(66,8)F,H,DLT,BETA
    8 FORMAT(/,' Design option 4',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO4(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,9)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
    9 FORMAT(/,' Outputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 5
      DM=100.
      BETA=10.1
      SIG=-1
      F=107.3
      H=79.4
      HT=126.365
      WRITE(66,10)F,H,HT,BETA
   10 FORMAT(/,' Design option 5',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO5(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,11)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   11 FORMAT(/,' Outputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 6
      DM=100.
      BETA=10.1
      SIG=-1
      F=107.3
      H=79.4
      DSRMR=10.9297
      WRITE(66,12)F,H,DSRMR,BETA
   12 FORMAT(/,' Design option 6',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO6(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,13)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   13 FORMAT(/,' Outputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 7
      DM=100.
      BETA=10.1
      SIG=-1
      THO=-40.608
      DFMR=35.4959
      DLS=28.0096
      WRITE(66,14)THO,DLS,DFMR,BETA
   14 FORMAT(/,' Design option 7',/,' Inputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      THO=THO*TR
      BETA=BETA*TR
      CALL ODUGEO7(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,15)F,H,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   15 FORMAT(/,' Outputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 8
      DM=100.
      BETA=10.1
      SIG=-1
      THO=-40.608
      THE=11.8767
      DLS=28.0096
      WRITE(66,16)THO,THE,DLS,BETA
   16 FORMAT(/,' Design option 8',/,' Inputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO8(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,17)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   17 FORMAT(/,' Outputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 9
      DM=100.
      BETA=10.1
      SIG=-1
      THO=-40.608
      THE=11.8767
      DSX=15.0
      WRITE(66,18)THO,THE,DSX,BETA
   18 FORMAT(/,' Design option 9',/,' Inputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO9(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,19)F,H,THU/TR,THL/TR,E,A,FS,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   19 FORMAT(/,' Outputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 10
      DM=100.
      BETA=10.1
      SIG=-1
      THO=-40.608
      THE=11.8767
      DSRMR=10.9297
      WRITE(66,20)THO,THE,DSRMR,BETA
   20 FORMAT(/,' Design option 10',/,' Inputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO10(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,21)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   21 FORMAT(/,' Outputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 11
      DM=100.
      BETA=10.1
      SIG=-1
      THO=-40.608
      THE=11.8767
      DLT=95.539
      WRITE(66,22)THO,THE,DLT,BETA
   22 FORMAT(/,' Design option 11',/,' Inputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO11(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,23)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   23 FORMAT(/,' Outputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 12
      DM=100.
      BETA=10.1
      SIG=-1
      THO=-40.608
      THE=11.8767
      HT=126.365
      WRITE(66,24)THO,THE,HT,BETA
   24 FORMAT(/,' Design option 12',/,' Inputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO12(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,25)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   25 FORMAT(/,' Outputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 13
      DM=100.
      F=107.3
      E=2.52016
      DLS=28.0096
      BETA=10.1
      SIG=-1
      WRITE(66,29)F,E,DLS,BETA
   29 FORMAT(/,' Design option 13',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO13(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,30)H,THO/TR,THU/TR,THL/TR,THE/TR,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   30 FORMAT(/,' Outputs:',/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 14
      DM=100.
      THO=-40.608
      THE=11.8767
      FS=17.3805
      BETA=10.1
      SIG=-1
      WRITE(66,31)THO,THE,FS,BETA
   31 FORMAT(/,' Design option 14',/,' Inputs:',/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
	THO=THO*TR
	THE=THE*TR
      CALL ODUGEO14(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,32)F,H,THU/TR,THL/TR,E,A,DSX,DSY,ALPHA/TR,DLS,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   32 FORMAT(/,' Outputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 15
      DM=100.
      F=107.3
      E=2.52016
      DSX=15.0
      BETA=10.1
      SIG=-1
      WRITE(66,33)F,E,DSX,BETA
   33 FORMAT(/,' Design option 15',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO15(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,34)H,THO/TR,THU/TR,THL/TR,THE/TR,A,FS,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   34 FORMAT(/,' Outputs:',/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 16
      DM=100.
      F=107.3
      A=6.8966
      FS=17.3805
      BETA=10.1
      SIG=-1
      WRITE(66,35)F,A,FS,BETA
   35 FORMAT(/,' Design option 16',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2)
      BETA=BETA*TR
      CALL ODUGEO16(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,36)H,THO/TR,THU/TR,THL/TR,THE/TR,E,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   36 FORMAT(/,' Outputs:',/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
C  ---------- Option 17
      DM=100.
      F=107.3
      THO=-40.608
      A=6.8966
      FS=17.3805
      SIG=-1
      WRITE(66,37)F,THO,A,FS
   37 FORMAT(/,' Design option 17',/,' Inputs:',/,
     1' MR focal length F:                        ',F8.3,/,
     1' Offset angle of main reflector THO:       ',F8.4,/,
     6' Subreflector dimension A:                 ',F8.4,/,
     7' SR half interfocal distance FS:           ',F8.4)
	THO=THO*TR
      CALL ODUGEO17(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,38)H,THU/TR,THL/TR,BETA/TR,THE/TR,E,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
   38 FORMAT(/,' Outputs:',/,
     2' Offset of Center of MR H:                 ',F8.3,/,
     2' Offset angle of top of the MR THU:        ',F8.4,/,
     3' Offset angle of bottom of the MR THL:     ',F8.4,/,
     2' Tilt between SR Z-axis and MR axis Beta:  ',F8.2,/,
     4' Half subtended angle of SR THE:           ',F8.4,/,
     5' Subreflector ecentricity E:               ',F8.5,/,
     3' Major axis of SR ellipse DSX:             ',F8.3,/,
     8' Major axis of SR ellipse DSY:             ',F8.4,/,
     9' Tilt SR Z-axis and MR Z-axis ALPHA:       ',F8.4,/,
     1' Feed to center of SR LS:                  ',F8.4,/,
     2' SR center to MR center LM:                ',F8.3,/,
     3' Gap between SR edge and MR edge DSRMR:    ',F8.4,/,
     3' Offset distance feed to MR edge DFMR:     ',F8.4,/,
     4' Maximum Z-axis length of system LT:       ',F8.3,/,
     5' Maximum distance along offset HT:         ',F8.3,/,
     6' SR center SR coordinates:                 ',F8.4,F9.4,/,
     6' SR center MR coordinates:                 ',F8.4,F9.4)
      ENDIF
C  ---------- Example 2
      IF(IEX.EQ.2.OR.IEX.EQ.0)THEN
C  ---------- Option 1
      DM=100.
      BETA=5.4
      SIG=1.
      WRITE(66,26)DM
   26 FORMAT(/,' Example 2. Greogorian',/,
     1' Main reflector diameter DM:               ',F8.3)
      F=82.8
      H=58.7
      DSX=15.0
      WRITE(66,2)F,H,DSX,BETA
      BETA=BETA*TR
      CALL ODUGEO1(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,3)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 2
      DM=100.
      BETA=5.4
      SIG=1.
      F=82.8
      H=58.7
      DLS=41.2498
      WRITE(66,4)F,H,DLS,BETA
      BETA=BETA*TR
      CALL ODUGEO2(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,5)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 3
      DM=100.
      BETA=5.4
      SIG=1.
      F=82.8
      H=58.7
      DFMR=11.3570
      WRITE(66,6)F,H,DFMR,BETA
      BETA=BETA*TR
      CALL ODUGEO3(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,7)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 4
      DM=100.
      BETA=5.4
      SIG=1.
      F=82.8
      H=58.7
      DLT=97.1173
      WRITE(66,8)F,H,DLT,BETA
      BETA=BETA*TR
      CALL ODUGEO4(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,9)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 5
      DM=100.
      BETA=5.4
      SIG=1.
      F=82.8
      H=58.7
      HT=125.967
      WRITE(66,10)F,H,HT,BETA
      BETA=BETA*TR
      CALL ODUGEO5(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,11)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 6
      DM=100.
      BETA=5.4
      SIG=1.
      F=82.8
      H=58.7
      DSRMR=10.2326
      WRITE(66,12)F,H,DSRMR,BETA
      BETA=BETA*TR
      CALL ODUGEO6(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,13)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 7
      DM=100.
      BETA=5.4
      SIG=1.
      THO=-39.0356
      DFMR=11.3570
      DLS=41.2498
      WRITE(66,14)THO,DLS,DFMR,BETA
      THO=THO*TR
      BETA=BETA*TR
      CALL ODUGEO7(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,15)F,H,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 8
      DM=100.
      BETA=5.4
      SIG=1.
      THO=-39.0356
      THE=11.9131
      DLS=41.2498
      WRITE(66,16)THO,THE,DLS,BETA
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO8(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,17)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 9
      DM=100.
      BETA=5.4
      SIG=1.
      THO=-39.0356
      THE=11.9131
      DSX=15.0
      WRITE(66,18)THO,THE,DSX,BETA
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO9(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,19)F,H,THU/TR,THL/TR,E,A,FS,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 10
      DM=100.
      BETA=5.4
      SIG=1.
      THO=-39.0356
      THE=11.9131
      DSRMR=10.2326
      WRITE(66,20)THO,THE,DSRMR,BETA
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO10(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,21)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 11
      DM=100.
      BETA=5.4
      SIG=1.
      THO=-39.0356
      THE=11.9131
      DLT=97.1173
      WRITE(66,22)THO,THE,DLT,BETA
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO11(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,23)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 12
      DM=100.
      BETA=5.4
      SIG=1.
      THO=-39.0356
      THE=11.9131
      HT=125.967
      WRITE(66,24)THO,THE,HT,BETA
      THO=THO*TR
      THE=THE*TR
      BETA=BETA*TR
      CALL ODUGEO12(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,25)F,H,THU/TR,THL/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 13
      DM=100.
      F=82.8
      E=.49277
      DLS=41.2498
      BETA=5.4
      SIG=1
      WRITE(66,29)F,E,DLS,BETA
      BETA=BETA*TR
      CALL ODUGEO13(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,30)H,THO/TR,THU/TR,THL/TR,THE/TR,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 14
      DM=100.
      THO=-39.0356
      THE=11.9131
      FS=14.1168
      BETA=5.4
      SIG=1
      WRITE(66,31)THO,THE,FS,BETA
      BETA=BETA*TR
	THO=THO*TR
	THE=THE*TR
      CALL ODUGEO14(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,32)F,H,THU/TR,THL/TR,E,A,DSX,DSY,ALPHA/TR,DLS,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 15
      DM=100.
      F=82.8
      E=.49277
      DSX=15.0
      BETA=5.4
      SIG=1
      WRITE(66,33)F,E,DSX,BETA
      BETA=BETA*TR
      CALL ODUGEO15(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,34)H,THO/TR,THU/TR,THL/TR,THE/TR,A,FS,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 16
      DM=100.
      F=82.8
      A=28.6477
      FS=14.1168
      BETA=5.4
      SIG=1
      WRITE(66,35)F,A,FS,BETA
      BETA=BETA*TR
      CALL ODUGEO16(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,36)H,THO/TR,THU/TR,THL/TR,THE/TR,E,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 17
      DM=100.
      F=82.8
      THO=-39.0356
      A=28.6477
      FS=14.1168
      SIG=1
      WRITE(66,37)F,THO,A,FS
	THO=THO*TR
      CALL ODUGEO17(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,38)H,THU/TR,THL/TR,BETA/TR,THE/TR,E,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
      ENDIF
  101 AB=6.
C  ---------- Example 3
      IF(IEX.EQ.3.OR.IEX.EQ.0)THEN
C  ---------- Option 1
      DM=45.
      BETA=6.0
      SIG=-1
      WRITE(66,27)DM
   27 FORMAT(/,' Example 3. Cassegrain',/,
     1' Main reflector diameter DM:               ',F8.3)
      F=38.0
      H=40.0
      DSX=10.0
      WRITE(66,2)F,H,DSX,BETA
      BETA=BETA*TR
      CALL ODUGEO1(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,3)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 2
      DM=45.
      BETA=6.0
      SIG=-1
      F=38.0
      H=40.0
      DLS=21.0487
      WRITE(66,4)F,H,DLS,BETA
      BETA=BETA*TR
      CALL ODUGEO2(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,5)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLM,DSRMR,DFMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 3
      DM=45.
      BETA=6.0
      SIG=-1
      F=38.0
      H=40.0
      DFMR=19.97599
      WRITE(66,6)F,H,DFMR,BETA
      BETA=BETA*TR
      CALL ODUGEO3(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,7)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DLT,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 4
      DM=45.
      BETA=6.0
      SIG=-1
      F=38.0
      H=40.0
      DLT=33.4299
      WRITE(66,8)F,H,DLT,BETA
      BETA=BETA*TR
      CALL ODUGEO4(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,DSY,
     1 ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
      WRITE(66,9)THO/TR,THU/TR,THL/TR,THE/TR,E,A,FS,DSX,DSY,ALPHA/TR,
     1 DLS,DLM,DSRMR,DFMR,HT,CSR(1),CSR(3),CSMR(1),CSMR(3)
C  ---------- Option 5
      DM=45.
      BETA=6.0
      SIG=-1
      F=38.0
      H=40.0
      HT=59.87143
      WRITE(66,10)F,H,HT,BETA
      BETA=BETA*TR
      CALL ODUGEO5(DM,F,…12811 tokens truncated… combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 5
      BSQ=SQRT(TAN(BETA/2.)/TAN((BETA-THO)/2.))
      E=(1.-SIG*BSQ)/(1.+SIG*BSQ)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 3
      THU=2.*ATAN((1.+E)*TAN((ALPHA-SIG*THE)/2.)/(1.-E))+BETA
C  -------- Equation 26
      F=DM/4./(TAN(-THU/2.)-TAN(-THO/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 18
      A=-SIG*DSX/((E**2-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E**2-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 15
      FS=A*E
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      CSMR(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CSMR(2)=0.
      CSMR(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      OCSMR=SQRT(CSMR(1)**2+CSMR(3)**2)
C  -------- Equation 40
      THC=ATAN(CSMR(1)/CSMR(3))
C  -------- Equation 41
      OCMR=2.*F/(1.+COS(THC))
C  -------- Equation 40
      CMR(1)=-OCMR*SIN(THC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THC)
C  -------- Equation 43
      DC=DM*SQRT(1.-4.*(CMR(1)-H)**2/DM**2)
      RETURN
      END

      SUBROUTINE ODUGEO10(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters IEEE AP Magazine June 2002, pp. 114 - 123
C
C  Equations by Christophe Granet
C
C  Option 10 Inputs
C
C  DM	    Main reflector diameter MR
C  THO	Offset angle of the center of MR from paraboloidal axis
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C
C  Outputs:
C
C  F	    Main reflector focal length
C  H	    Center distance of main reflector offset
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  E	    Subreflector eccentricity
C  A	    Subreflector conic section parameter
C  FS	    SR half the interfocal distance A*E
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLS	Distance between the feed and the center of the SR
C  DLM	Distance between the center of the SR and the center of MR
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	    edge Q1
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 5
      BSQ=SQRT(TAN(BETA/2.)/TAN((BETA-THO)/2.))
      E=(1.-SIG*BSQ)/(1.+SIG*BSQ)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 3
      THU=2.*ATAN((1.+E)*TAN((ALPHA-SIG*THE)/2.)/(1.-E))+BETA
C  -------- Equation 26
      F=DM/4./(TAN(-THU/2.)-TAN(-THO/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 21
      A=(DSRMR-H+DM/2.)/((SIG+1.)/2.*(E**2-1.)*SIN(THL)/(E*COS(BETA-
     1 THL)+1.)-(SIG-1.)/2.*(E**2-1.)*SIN(THU)/(E*COS(BETA-THU)+1.))
C  -------- Equation 15
      FS=A*E
C  -------- Equation 27
      DSX=-SIG*A*((E*E-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E*E-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      CSMR(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CSMR(2)=0.
      CSMR(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      OCSMR=SQRT(CSMR(1)**2+CSMR(3)**2)
C  -------- Equation 40
      THC=ATAN(CSMR(1)/CSMR(3))
C  -------- Equation 41
      OCMR=2.*F/(1.+COS(THC))
C  -------- Equation 40
      CMR(1)=-OCMR*SIN(THC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THC)
C  -------- Equation 43
      DC=DM*SQRT(1.-4.*(CMR(1)-H)**2/DM**2)
      RETURN
      END

      SUBROUTINE ODUGEO11(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters IEEE AP Magazine June 2002, pp. 114 - 123
C
C  Equations by Christophe Granet
C
C  Option 11 Inputs
C
C  DM	    Main reflector diameter MR
C  THO	Offset angle of the center of MR from paraboloidal axis
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C
C  Outputs:
C
C  F	    Main reflector focal length
C  H	    Center distance of main reflector offset
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  E	    Subreflector eccentricity
C  A	    Subreflector conic section parameter
C  FS	    SR half the interfocal distance A*E
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLS	Distance between the feed and the center of the SR
C  DLM	Distance between the center of the SR and the center of MR
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	   ,edge Q1
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 5
      BSQ=SQRT(TAN(BETA/2.)/TAN((BETA-THO)/2.))
      E=(1.-SIG*BSQ)/(1.+SIG*BSQ)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 3
      THU=2.*ATAN((1.+E)*TAN((ALPHA-SIG*THE)/2.)/(1.-E))+BETA
C  -------- Equation 26
      F=DM/4./(TAN(-THU/2.)-TAN(-THO/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 19
      A=(DLT+(2.*H-DM)**2/16./F-F)/((SIG-1.)/2.*(E**2-1.)*COS(THU)
     1/(E*COS(BETA-THU)+1.)-
     1(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 15
      FS=A*E
C  -------- Equation 27
      DSX=-SIG*A*((E*E-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E*E-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      CSMR(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CSMR(2)=0.
      CSMR(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      OCSMR=SQRT(CSMR(1)**2+CSMR(3)**2)
C  -------- Equation 40
      THC=ATAN(CSMR(1)/CSMR(3))
C  -------- Equation 41
      OCMR=2.*F/(1.+COS(THC))
C  -------- Equation 40
      CMR(1)=-OCMR*SIN(THC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THC)
C  -------- Equation 43
      DC=DM*SQRT(1.-4.*(CMR(1)-H)**2/DM**2)
      RETURN
      END

      SUBROUTINE ODUGEO12(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters IEEE AP Magazine June 2002, pp. 114 - 123
C
C  Equations by Christophe Granet
C
C  Option 12 Inputs
C
C  DM	    Main reflector diameter MR
C  THO	Offset angle of the center of MR from paraboloidal axis
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C
C  Outputs:
C
C  F	    Main reflector focal length
C  H	    Center distance of main reflector offset
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  E	    Subreflector eccentricity
C  A	    Subreflector conic section parameter
C  FS	    SR half the interfocal distance A*E
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLS	Distance between the feed and the center of the SR
C  DLM	Distance between the center of the SR and the center of MR
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	    edge Q1
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 5
      BSQ=SQRT(TAN(BETA/2.)/TAN((BETA-THO)/2.))
      E=(1.-SIG*BSQ)/(1.+SIG*BSQ)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 3
      THU=2.*ATAN((1.+E)*TAN((ALPHA-SIG*THE)/2.)/(1.-E))+BETA
C  -------- Equation 26
      F=DM/4./(TAN(-THU/2.)-TAN(-THO/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 20
      A=(HT-H-DM/2.)/((SIG+1.)/2.*(E**2-1.)*SIN(THU)/(E*COS(BETA-
     1 THU)+1.)-(SIG-1.)/2.*(E**2-1.)*SIN(THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 15
      FS=A*E
C  -------- Equation 27
      DSX=-SIG*A*((E*E-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E*E-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      CSMR(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CSMR(2)=0.
      CSMR(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      OCSMR=SQRT(CSMR(1)**2+CSMR(3)**2)
C  -------- Equation 40
      THC=ATAN(CSMR(1)/CSMR(3))
C  -------- Equation 41
      OCMR=2.*F/(1.+COS(THC))
C  -------- Equation 40
      CMR(1)=-OCMR*SIN(THC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THC)
C  -------- Equation 43
      DC=DM*SQRT(1.-4.*(CMR(1)-H)**2/DM**2)
      RETURN
      END

      SUBROUTINE ODUGEO13(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters, part 2, IEEE AP Magazine Dec. 2003, pp. 86-89
C
C  Equations by Christophe Granet
C
C  Option 13 Inputs
C
C  DM	    Main reflector diameter MR
C  F	    Main reflector focal length
C  E	    Subreflector eccentricity
C  DLS	Distance between the feed and the center of the SR
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C
C  Outputs:
C
C  H	    Center distance of main reflector offset
C  THO	Offset angle of the center of MR from paraboloidal axis
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  A	    Subreflector conic section parameter
C  FS	    SR half the interfocal distance A*E
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLM	Distance between the center of the SR and the center of MR
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	    edge Q1
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 40
      THO=BETA-2.*ATAN(((E+1.)/(E-1.))**2*TAN(BETA/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 2
      THU=-2.*ATAN((2.*H+DM)/4./F)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 7
      THE=-SIG*(2.*ATAN((1.-E)*TAN((THU-BETA)/2.)/(1.+E))-ALPHA)
C  -------- Equation 22
      A=DLS/(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 15
      FS=A*E
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 27
      DSX=-SIG*A*((E*E-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E*E-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END

      SUBROUTINE ODUGEO14(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters, part 2, IEEE AP Magazine Dec. 2003, pp. 86-89
C
C  Equations by Christophe Granet
C
C  Option 14 Inputs
C
C  DM	    Main reflector diameter MR
C  THO	Offset angle of the center of MR from paraboloidal axis
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  FS	    SR half the interfocal distance A*E
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C
C  Outputs:
C
C  F	    Main reflector focal length
C  H	    Center distance of main reflector offset
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  E	    Subreflector eccentricity
C  A	    Subreflector conic section parameter
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLS	Distance between the feed and the center of the SR
C  DLM	Distance between the center of the SR and the center of MR
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	    edge Q1
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 5
      BSQ=SQRT(TAN(BETA/2.)/TAN((BETA-THO)/2.))
      E=(1.-SIG*BSQ)/(1.+SIG*BSQ)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 17
      A=FS/E
C  -------- Equation 3
      THU=2.*ATAN((1.+E)*TAN((ALPHA-SIG*THE)/2.)/(1.-E))+BETA
C  -------- Equation 26
      F=DM/4./(TAN(-THU/2.)-TAN(-THO/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 27
      DSX=-SIG*A*((E*E-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E*E-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END

      SUBROUTINE ODUGEO15(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters, part 2, IEEE AP Magazine Dec. 2003, pp. 86-89
C
C  Equations by Christophe Granet
C
C  Option 15 Inputs
C
C  DM		Main reflector diameter MR
C  F	    Main reflector focal length
C  E	    Subreflector eccentricity
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C
C  Outputs:
C
C  H	    Center distance of main reflector offset
C  THO	Offset angle of the center of MR from paraboloidal axis
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  A	    Subreflector conic section parameter
C  FS	    SR half the interfocal distance A*E
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLS	Distance between the feed and the center of the SR
C  DLM	Distance between the center of the SR and the center of MR
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	    edge Q1
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 40
      THO=BETA-2.*ATAN(((E+1.)/(E-1.))**2*TAN(BETA/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 2
      THU=-2.*ATAN((2.*H+DM)/4./F)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 7
      THE=-SIG*(2.*ATAN((1.-E)*TAN((THU-BETA)/2.)/(1.+E))-ALPHA)
C  -------- Equation 18
      A=-SIG*DSX/((E**2-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E**2-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 15
      FS=A*E
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END

      SUBROUTINE ODUGEO16(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters, part 2, IEEE AP Magazine Dec. 2003, pp. 86-89
C
C  Equations by Christophe Granet
C
C  Option 16 Inputs
C
C  DM	    Main reflector diameter MR
C  F	    Main reflector focal length
C  A	    Subreflector conic section parameter
C  FS	    SR half the interfocal distance A*E
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C
C  Outputs:
C
C  H	    Center distance of main reflector offset
C  THO	Offset angle of the center of MR from paraboloidal axis
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  E	    Subreflector eccentricity
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLS	Distance between the feed and the center of the SR
C  DLM	Distance between the center of the SR and the center of MR
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	    edge Q1
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 41
      E=FS/A
C  -------- Equation 40
      THO=BETA-2.*ATAN(((E+1.)/(E-1.))**2*TAN(BETA/2.))
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 2
      THU=-2.*ATAN((2.*H+DM)/4./F)
C  -------- Equation 4
      THL=-2.*ATAN((2.*H-DM)/4./F)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 7
      THE=-SIG*(2.*ATAN((1.-E)*TAN((THU-BETA)/2.)/(1.+E))-ALPHA)
C  -------- Equation 27
      DSX=-SIG*A*((E*E-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E*E-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END

      SUBROUTINE ODUGEO17(DM,F,H,THO,THU,THL,BETA,THE,E,A,FS,DSX,
     1 DSY,ALPHA,DLS,DLM,DSRMR,DFMR,DLT,HT,CSR,CSMR,SIG)
C
C  Geometry of Offset Dual Reflector satisfying Mizugutch condition
C  for minimum cross pol.
C
C  Design equations for Classical Offset Cassegrain or Gregorian
C  Dual-Reflector Antennas from Combinations of Prescribed
C  Geometric parameters, part 2, IEEE AP Magazine Dec. 2003, pp. 86-89
C
C  Equations by Christophe Granet
C
C  Option 17 Inputs
C
C  DM	    Main reflector diameter MR
C  F	    Main reflector focal length
C  THO	Offset angle of the center of MR from paraboloidal axis
C  A	    Subreflector conic section parameter
C  FS	    SR half the interfocal distance A*E
C
C  Outputs:
C
C  H	    Center distance of main reflector offset
C  THU	Offset angle of the top of MR
C  THL	Offset angle of the bottom of MR
C  BETA   Tilt angle between the SR coordinate system Z-axis and the
C	    MR coordinate system Z-axis
C  THE	Angle between the feed Z-axis and SR edge (half subtended
C	    angle of the subreflector from feed)
C  E	    Subreflector eccentricity
C  DSX	Major axis of the SR approximated elliptical aperture taken
C	    parallel to the SR X-axis
C  DSY	Major axis of the SR approximated elliptical aperture taken
C	    parallel the SR Y-axis
C  ALPHA  Tilt angle between SR coordinate system Z-axis and the feed
C	    coordinate system Z-axis
C  DLS	Distance between the feed and the center of the SR
C  DLM	Distance between the center of the SR and the center of MR
C  DSRMR  Minimum vertical distance (along offset axis) between the SR
C	    edges (P1 and P2) and the MR edge Q1 (projected aperture clearance)
C  DFMR   Minimum along offset axis (X-axis) between the feed and the MR
C	    edge Q1
C  DLT	Maximum length (along the z-axis) of the two reflector combination
C  HT	    Maximum offset axis (X-axis) distance of the two-reflector
C	    combination
C  CSR	Point expressed in the SR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  CSMR   Point expressed in the MR coordinate system defining the centre
C	    of the approximated elliptical aperture
C  SIG	-1 Cassegrain, +1 Gregorian
C
      DIMENSION CSR(1),CMR(3),CSMR(3),XX(5)
      EXTERNAL SUMDIA
C  -------- Equation 41
      E=FS/A
C  -------- Equation 23
      H=2.*F*TAN(-THO/2.)
C  -------- Equation 42
      THU=-2.*ATAN(TAN(-THO/2.)+DM/4./F)
C  -------- Equation 43
      THL=-2.*ATAN(TAN(-THO/2.)-DM/4./F)
C  -------- Equation 44
      AA=TAN(THO/2.)
      BB=1.-((E-1.)/(E+1.))**2
      CC=((E-1.)/(E+1.))**2*TAN(THO/2.)
      DEL=BB**2-4.*AA*CC
      BETA=2.*ATAN((-BB+SQRT(DEL))/2./AA)
C  -------- Equation 6
      ALPHA=2.*ATAN((E+1.)*TAN(BETA/2.)/(E-1.))
C  -------- Equation 7
      THE=-SIG*(2.*ATAN((1.-E)*TAN((THU-BETA)/2.)/(1.+E))-ALPHA)
C  -------- Equation 27
      DSX=-SIG*A*((E*E-1.)*SIN(BETA-THU)/(E*COS(BETA-THU)+1.)-
     1(E*E-1.)*SIN(BETA-THL)/(E*COS(BETA-THL)+1.))
C  -------- Equation 8
      DLS=A*(2.+(E*E-1.)/(E*COS(BETA-THO)+1.))
C  -------- Equation 9
      DLM=-A*(E*E-1.)/(E*COS(BETA-THO)+1.)-H/SIN(THO)
C  -------- Equation 10
      DFMR=H-DM/2.+2*FS*SIN(BETA)
C  -------- Equation 11
      DSRMR=H-DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)
C  -------- Equation 12
      DLT=-A*(SIG+1.)/2.*(E**2-1.)*COS(THL)/(E*COS(BETA-THL)+1.)
     1+A*(SIG-1.)/2.*(E**2-1.)*COS(THU)/(E*COS(BETA-THU)+1.)
     2-(2.*H-DM)**2/16./F+F
C  -------- Equation 13
      HT=H+DM/2.-A*(SIG-1.)/2.*(E**2-1.)*SIN(THL)/
     1(E*COS(BETA-THL)+1.)+A*(SIG+1.)/2.*(E**2-1.)*SIN(THU)/
     1(E*COS(BETA-THU)+1.)
C  -------- Equation 33
      OP1=-SIG*A*(E*E-1.)/(E*COS(THL-BETA)+1.)
C  -------- Equation 34
      OP2=-SIG*A*(E*E-1.)/(E*COS(THU-BETA)+1.)
C  -------- Equation 38  SR coordinate system
C      CSR(1)=-SIG*(OP2*SIN(BETA-THU)+OP1*SIN(BETA-THL))/2.
      CSR(1)=(OP1*SIN(ALPHA+SIG*THE)+OP2*SIN(ALPHA-SIG*THE))/2.
      CSR(2)=0.
      CSR(3)=A*SQRT(1.+CSR(1)**2/(FS**2-A**2))-FS
C  -------- Equation 39  MR coordinate system
      XX(2)=E
      XX(3)=A
      XX(4)=THE
      XX(5)=ALPHA
      AP=0.
      BP=4.*ACOS(0.)
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END

      FUNCTION SUMDIA(X)
C
C  Diameter of subreflector of Dragonian
C
C  X(1)    Angle of plane
C  X(2)    Eccentricity
C  X(3)    Subreflector radial parameter A
C  X(4)    Feed half subtended angle
C  X(5)    Tilt angle between SR coordinate system Zfs-axis
C	     and the feed coordinate system Zf-axis
C
      DIMENSION X(5)
      SUMDIA=2.*X(3)*(X(2)**2-1.)*SIN(X(4))*SIN(X(1))/(X(2)*(-SIN(X(5))
     1*SIN(X(4))*COS(X(1))+COS(X(5))*COS(X(4)))-1.)
      RETURN
      END

      SUBROUTINE FIBON(X,A,B,ALPHA,AF,BF,FA,FB,FUNC,RT) 
C 
C  FIBONACCI SEARCH ALGORITHM 
C 
C  THIS SEARCHES A FUNCTION OF A SINGLE VARIABLE
C  FOR A MAXIMUM (MINIMUM)
C  SEARCH INTERVAL  A .LE. X .GE. B 
C  THE ROUTINE REDUCES THE INTERVAL TO AF, BF BY USING THE
C  THE REDUCTION FACTOR: ALPHA .LE. .5
C  FA, FB THE VALUE OF THE FUNCTION AT THE FINAL INTERVAL EDGES 
C  FUNC EXTERNAL FUNCTION OF X(1) 
C  X  ARRAY OF VARIABLES PASSED TO FUNC 
C  ALPHA IS LIMITED TO .5 TO 10.**(-5)
C 
      DIMENSION FIB(25),X(1)
      EXTERNAL FUNC
      AF=A
      BF=B
      FIB(1)=1. 
      FIB(2)=2. 
      AL=1./ALPHA 
      IF(AL.LT.2.)RETURN
      K=2 
      IF(AL.LT.3)GOTO2
      DO1I=3,25 
      FIB(I)=FIB(I-1)+FIB(I-2)
      IF(AL.LE.FIB(I))GOTO3 
    1 CONTINUE
      K=25
      GOTO4 
    3 K=I 
    4 D=BF-AF 
      DL=FIB(K-2)/FIB(K)*D
      AD=AF+DL
      BD=BF-DL
      X(1)=AD 
      T=FUNC(X) 
      X(1)=BD 
      U=FUNC(X) 
    5 IF(RT*(U-T).GE.0.)GOTO7 
    6 BF=BD 
      U=T 
      K=K-1 
      IF(K.EQ.2)GOTO2 
      BD=AD 
      AD=AF+FIB(K-2)/FIB(K)*(BF-AF) 
      X(1)=AD 
      T=FUNC(X) 
      GOTO5 
    7 AF=AD 
      T=U 
      K=K-1 
      IF(K.EQ.2)GOTO2 
      AD=BD 
      BD=BF-FIB(K-2)/FIB(K)*(BF-AF) 
      X(1)=BD 
      U=FUNC(X) 
      GOTO5 
    2 AD=AF+.495*(BF-AF)
      BD=BF-.495*(BF-AF)
      X(1)=AD 
      T=FUNC(X) 
      X(1)=BD 
      U=FUNC(X) 
      IF(RT*(U-T).LE.0.)GOTO9 
    8 AF=(AF+BF)/2. 
      FA=(U+T)/2. 
      X(1)=BF 
      FB=FUNC(X)
      RETURN
    9 BF=(AF+BF)/2. 
      FB=(U+T)/2. 
      X(1)=AF 
      FA=FUNC(X)
      RETURN
C 
C  REF: D.A. PIERRE " OPTIMIZATION THEORY WITH APPLICATIONS"
C       PP. 280 
C  REF: J.L. KUESTER, " OPTIMIZATION TECHNIQUES WITH FORTRAN" 
C       PP. 286 
C 
      END 

