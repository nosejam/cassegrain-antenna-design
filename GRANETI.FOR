      PROGRAM GRANETI
C
C  Inverse Cassegrain Dual Reflector Geometry
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Code: Tom Milligan
C  Written  25 Jan 03
C
      OPEN(66,FILE='graneti.out')
      TR=ACOS(0.)/90.
C
C  Example 1
C
C  Option 1
C
      DM=100
      ALM=250.
      THETE=70.
      THETP=70.
      ALPHA=-80.
      CALL ICASGEO1(DM,ALM,THETE*TR,THETP*TR,ALPHA*TR,FOCAL,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALS,DSRMR,DCLEAR)
      WRITE(66,1)DM,ALM,THETE,THETP,ALPHA,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALS,DSRMR,DCLEAR
    1 FORMAT(/,' Inverse Cassegrain Option 1',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     6' Outputs:',/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 2
C
      DM=100
      ALS=128.197
      THETE=70.
      THETP=70.
      ALPHA=-80.
      CALL ICASGEO2(DM,ALS,THETE*TR,THETP*TR,ALPHA*TR,FOCAL,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,DSRMR,DCLEAR)
      WRITE(66,2)DM,ALS,THETE,THETP,ALPHA,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALM,DSRMR,DCLEAR
    2 FORMAT(/,' Inverse Cassegrain Option 2',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     6' Outputs:',/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 3
C
      DM=100
      FOCAL=-18.1272
      ALS=128.197
      THETE=70.
      THETP=70.
      CALL ICASGEO3(DM,ALS,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,DSRMR,DCLEAR)
      WRITE(66,3)DM,FOCAL,ALS,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALM,
     2 DSRMR,DCLEAR
    3 FORMAT(/,' Inverse Cassegrain Option 3',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     6' Outputs:',/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 4
C
      DM=100
      FOCAL=-18.1272
      ALM=250.0
      THETE=70.
      THETP=70.
      CALL ICASGEO4(DM,ALM,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALS,DSRMR,DCLEAR)
      WRITE(66,4)DM,FOCAL,ALM,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALS,
     2 DSRMR,DCLEAR
    4 FORMAT(/,' Inverse Cassegrain Option 4',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     6' Outputs:',/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 5
C
      DM=100
      FOCAL=-18.1272
      DSRMR=24.8266
      THETE=70.
      THETP=70.
      CALL ICASGEO5(DM,DSRMR,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,ALS,DCLEAR)
      WRITE(66,5)DM,FOCAL,DSRMR,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALM,ALS,
     2 DCLEAR
    5 FORMAT(/,' Inverse Cassegrain Option 5',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     6' Outputs:',/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 6
C
      DM=100
      FOCAL=-18.1272
      DCLEAR=24.8266
      THETE=70.
      THETP=70.
      CALL ICASGEO6(DM,DCLEAR,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,ALS,DSRMR)
      WRITE(66,6)DM,FOCAL,DSRMR,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALM,ALS,
     2 DCLEAR
    6 FORMAT(/,' Inverse Cassegrain Option 6',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     6' Outputs:',/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4)
C
C  Option 7
C
      DM=100
      THETP=70.
      ALPHA=-80.
      ALS=128.197
      ALM=250.
      CALL ICASGEO7(DM,THETP*TR,ALPHA*TR,ALS,ALM,FOCAL,HT,THETO,THETU,
     1 THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETE,DSRMR,DCLEAR)
      WRITE(66,7)DM,THETP,ALPHA,ALS,ALM,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETE/TR,DSRMR,
     2 DCLEAR
    7 FORMAT(/,' Inverse Cassegrain Option 7',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     6' Outputs:',/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 8
C
      DM=100
      EC=.632872
      THETE=70.
      ALPHA=-80.
      ALS=128.197
      CALL ICASGEO8(DM,EC,THETE*TR,ALPHA*TR,ALS,FOCAL,HT,THETO,THETU,
     1 THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALM,DSRMR,DCLEAR)
      WRITE(66,8)DM,EC,THETE,ALPHA,ALS,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETP/TR,ALM,DSRMR,
     2 DCLEAR
    8 FORMAT(/,' Inverse Cassegrain Option 8',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     6' Outputs:',/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 9
C
      DM=100
      EC=.632872
      THETE=70.
      ALPHA=-80.
      ALS=128.197
      CALL ICASGEO8(DM,EC,THETE*TR,ALPHA*TR,ALS,FOCAL,HT,THETO,THETU,
     1 THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALM,DSRMR,DCLEAR)
      WRITE(66,8)DM,EC,THETE,ALPHA,ALS,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETP/TR,ALM,DSRMR,
     2 DCLEAR
    9 FORMAT(/,' Inverse Cassegrain Option 9',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     6' Outputs:',/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Option 10
C
      DM=100
      EC=.632872
      THETE=70.
      ALPHA=-80.
      DSRMR=24.8266
      CALL ICASGE10(DM,EC,THETE*TR,ALPHA*TR,DSRMR,FOCAL,HT,THETO,
     1 THETU,THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALS,ALM,DCLEAR)
      WRITE(66,10)DM,EC,THETE,ALPHA,DSRMR,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETP/TR,ALS,ALM,
     2 DCLEAR
   10 FORMAT(/,' Inverse Cassegrain Option 10',/,' Inputs:',/,
     1' Main Diameter, DM:                   ',F8.1,/,
     2' Subreflector eccentricity, EC:       ',F8.6,/,
     3' Feed 1/2 subtended angle, THETE:     ',F8.1,/,
     5' Tilt between SR and Feed, ALPHA:     ',F8.1,/,
     9' Distance between P2 and Q1, DSRMR:   ',F8.4,/,
     6' Outputs:',/,
     7' Main focal length, FOCAL:            ',F8.4,/,
     8' Main reflector offset, HT:           ',F8.4,/,
     9' Main reflector offset angle, THETO:  ',F8.3,/,
     1' Main offset angle to top, THETU:     ',F8.3,/,
     1' Main offset angle to bottom, THETL:  ',F8.3,/,
     3' Subref. major axis, A:               ',F8.3,/,
     4' Subref. focal length, FS:            ',F8.3,/,
     5' SR aperture center X-axis: CSRX:     ',F8.4,/,
     5' SR aperture center Z-axis: CSRZ:     ',F8.2,/,
     6' SR ellipsoidal axis X-axis: DSX      ',F8.3,/,
     6' SR ellipsoidal axis Y-axis: DSY      ',F8.3,/,
     6' SR ellipsoidal axis Z-axis: DSZ      ',F8.3,/,
     7' Tilt of SR axis and MR axis: BETA:   ',F8.1,/,
     4' Feed tilt angle, THETP:              ',F8.1,/,
     8' Feed to SR center, ALS:              ',F8.3,/,
     2' P0 to Q0, ALM:                       ',F8.1,/,
     1' Ray clearance to MR top, DCLEAR:     ',F8.4)
C
C  Example 2
C
      WRITE(66,11)
   11 FORMAT(//,' **********************************************',/,
     1' Example 2',/,' **********************************************')
C
C  Option 1
C
      DM=100
      ALM=200.
      THETE=35.
      THETP=60
      ALPHA=-60.
      CALL ICASGEO1(DM,ALM,THETE*TR,THETP*TR,ALPHA*TR,FOCAL,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALS,DSRMR,DCLEAR)
      WRITE(66,1)DM,ALM,THETE,THETP,ALPHA,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALS,DSRMR,DCLEAR
C
C  Option 2
C
      DM=100
      ALS=165.004
      THETE=35.
      THETP=60
      ALPHA=-60.
      CALL ICASGEO2(DM,ALS,THETE*TR,THETP*TR,ALPHA*TR,FOCAL,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,DSRMR,DCLEAR)
      WRITE(66,2)DM,ALS,THETE,THETP,ALPHA,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALM,DSRMR,DCLEAR
C
C  Option 3
C
      DM=100
      FOCAL=-79.2899
      ALS=165.004
      THETE=35.
      THETP=60
      CALL ICASGEO3(DM,ALS,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,DSRMR,DCLEAR)
      WRITE(66,3)DM,FOCAL,ALS,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALM,
     2 DSRMR,DCLEAR
C
C  Option 4
C
      DM=100
      FOCAL=-79.2899
      ALM=200.0
      THETE=35.
      THETP=60
      CALL ICASGEO4(DM,ALM,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALS,DSRMR,DCLEAR)
      WRITE(66,4)DM,FOCAL,ALM,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALS,
     2 DSRMR,DCLEAR
C
C  Option 5
C
      DM=100
      FOCAL=-79.2899
      DSRMR=96.1897
      THETE=35.
      THETP=60
      CALL ICASGEO5(DM,DSRMR,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,ALS,DCLEAR)
      WRITE(66,5)DM,FOCAL,DSRMR,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALM,ALS,
     2 DCLEAR
C
C  Option 6
C
      DM=100
      FOCAL=-79.2899
      DCLEAR=26.2474
      THETE=35.
      THETP=60
      CALL ICASGEO6(DM,DCLEAR,THETE*TR,THETP*TR,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,ALS,DSRMR)
      WRITE(66,6)DM,FOCAL,DSRMR,THETE,THETP,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,ALPHA/TR,ALM,ALS,
     2 DCLEAR
C
C  Option 7
C
      DM=100
      THETP=60
      ALPHA=-60.
      ALS=165.004
      ALM=200.
      CALL ICASGEO7(DM,THETP*TR,ALPHA*TR,ALS,ALM,FOCAL,HT,THETO,THETU,
     1 THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETE,DSRMR,DCLEAR)
      WRITE(66,7)DM,THETP,ALPHA,ALS,ALM,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETE/TR,DSRMR,
     2 DCLEAR
C
C  Option 8
C
      DM=100
      EC=.5
      THETE=35.
      ALPHA=-60.
      ALS=165.004
      CALL ICASGEO8(DM,EC,THETE*TR,ALPHA*TR,ALS,FOCAL,HT,THETO,THETU,
     1 THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALM,DSRMR,DCLEAR)
      WRITE(66,8)DM,EC,THETE,ALPHA,ALS,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETP/TR,ALM,DSRMR,
     2 DCLEAR
C
C  Option 9
C
      DM=100
      EC=.5
      THETE=35.
      ALPHA=-60.
      ALS=165.004
      CALL ICASGEO8(DM,EC,THETE*TR,ALPHA*TR,ALS,FOCAL,HT,THETO,THETU,
     1 THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALM,DSRMR,DCLEAR)
      WRITE(66,8)DM,EC,THETE,ALPHA,ALS,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETP/TR,ALM,DSRMR,
     2 DCLEAR
C
C  Option 10
C
      DM=100
      EC=.5
      THETE=35.
      ALPHA=-60.
      DSRMR=96.1897
      CALL ICASGE10(DM,EC,THETE*TR,ALPHA*TR,DSRMR,FOCAL,HT,THETO,
     1 THETU,THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALS,ALM,DCLEAR)
      WRITE(66,10)DM,EC,THETE,ALPHA,DSRMR,FOCAL,HT,THETO/TR,THETU/TR,
     1 THETL/TR,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA/TR,THETP/TR,ALS,ALM,
     2 DCLEAR
      END

      SUBROUTINE ICASPTS(DM,FOCAL,HT,EC,A,FS,BETA,THETE,THETP,ALPHA,ALS,
     1 XFO,ZFO,XQ0,ZQ0,XQ1,ZQ1,XQ2,ZQ2,XP0,ZP0,XP1,ZP1,XP2,ZP2)
C
C  Inverse Cassegrain Dual Reflector Points
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  FOCAL  MR focal length (negative)
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C
C  Outputs:
C
C  XFO	Feed point X-axis
C  ZFO	Feed point Z-axis
C  XQ0	Main refector center X-axis
C  ZQ0	Main refector center Z-axis
C  XQ1	Main refector upper edge X-axis
C  ZQ1	Main refector upper edge Z-axis
C  XQ2	Main refector lower edge X-axis
C  ZQ2	Main refector lower edge Z-axis
C  XP0	Subrefector center X-axis
C  ZP0	Subrefector center Z-axis
C  XP1	Subrefector upper edge X-axis
C  ZP1	Subrefector upper edge Z-axis
C  XP2	Subrefector lower edge X-axis
C  ZP2	Subrefector lower edge Z-axis
C
C  Location of point Fo - Feed Point
      XFO=2.*FS*SIN(BETA)
      ZFO=2.*FS*COS(BETA)
C  Location of point Q0 - Center of main reflector
      XQ0=HT
      ZQ0=HT**2/4./FOCAL-FOCAL
C  Location of point Q1 - Top of main reflector
      XQ1=HT+DM/2.
      ZQ1=(2.*HT+DM)**2/16./FOCAL -FOCAL
C  Location of point Q2 - Bottom of main reflector
      XQ2=HT-DM/2.
      ZQ2=(2.*HT-DM)**2/16./FOCAL-FOCAL
C  Location of point P0 - Center of subreflector
      XP0=2.*FS*SIN(BETA)+ALS*SIN(THETP)
      ZP0=2.*FS+COS(BETA)+ALS*COS(THETP)
C  Location of point P1 - Top of subreflector
      XP1=2.*FS*SIN(BETA)-A*(EC**2-1.)*SIN(THETE+THETP)/(EC*COS(ALPHA
     1 +THETE)+1.)
      ZP1=2.*FS*COS(BETA)-A*(EC**2-1.)*COS(THETE+THETP)/(EC*COS(ALPHA
     1 +THETE)+1.)
C  Location of point P2 - Bottom of subreflector
      XP2=2.*FS*SIN(BETA)-A*(EC**2-1.)*SIN(THETP-THETE)/(EC*COS(ALPHA
     1 -THETE)+1.)
      ZP2=2.*FS*COS(BETA)-A*(EC**2-1.)*COS(THETP-THETE)/(EC*COS(ALPHA
     1 -THETE)+1.)
      RETURN
      END

      SUBROUTINE ICASGEO1(DM,ALM,THETE,THETP,ALPHA,FOCAL,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALS,DSRMR,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 1
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C
C  Outputs:
C
C  FOCAL  MR focal length (negative)
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 3
C  FOCAL   MR focal length (negative)
      FOCAL=DM*SIN(BETA)/(4.*SIN(ALPHA)*TAN(THETE/2.))
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 6
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=SIN(THETP-THETO)*(ALM-2.*FOCAL/(1.+COS(THETO)))/(2.*SIN(ALPHA))
C  ------- Equation 7
C  A	   SR ellipsoidal parameter
      A=FS/EC
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 10
C  ALS	   Distance between focal point F(0) and P(0) on SR (feed to SR)
      ALS=2.*A-ALM+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      FUNCTION DSYSF(XX)
C
C  Search function
C
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
      DIMENSION XX(5)
      DSYSF=2.*XX(2)*(XX(3)**2-1.)*SIN(XX(4))*SIN(XX(1))/(XX(3)*(
     1 SIN(XX(4))*SIN(XX(5))*COS(XX(1))-COS(XX(4))*COS(XX(5)))-1.)
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

      SUBROUTINE ICASGEO2(DM,ALS,THETE,THETP,ALPHA,FOCAL,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,DSRMR,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 2
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C
C  Outputs:
C
C  FOCAL  MR focal length (negative)
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 3
C  FOCAL   MR focal length (negative)
      FOCAL=DM*SIN(BETA)/(4.*SIN(ALPHA)*TAN(THETE/2.))
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 15
C  A	   SR ellipsoidal parameter
      A=-ALS*(EC*COS(ALPHA)+1.)/(EC**2-1.)
C  ------- Equation 16
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=A*EC
C  ------- Equation 17
C  ALM	   Distance between SR point P(0) and point Q(0) on MR
C	   distance between SR and MR
      ALM=2.*A-ALS+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGEO3(DM,ALS,THETE,THETP,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,DSRMR,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 3
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  FOCAL  MR focal length (negative)
C
C  Outputs:
C
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 18
C  ALPHA   (radians) Tilt angle between SR coordinate system Zsr-axis
C	   and feed coordinate system Zf-axis
      ALPHA=ATAN(DM*SIN(THETP)/(4.*FOCAL*TAN(THETE/2.)+DM*COS(THETP)))
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 15
C  A	   SR ellipsoidal parameter
      A=-ALS*(EC*COS(ALPHA)+1.)/(EC**2-1.)
C  ------- Equation 16
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=A*EC
C  ------- Equation 17
C  ALM	   Distance between SR point P(0) and point Q(0) on MR
C	   distance between SR and MR
      ALM=2.*A-ALS+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGEO4(DM,ALM,THETE,THETP,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALS,DSRMR,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 4
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  FOCAL  MR focal length (negative)
C
C  Outputs:
C
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 18
C  ALPHA   (radians) Tilt angle between SR coordinate system Zsr-axis
C	   and feed coordinate system Zf-axis
      ALPHA=ATAN(DM*SIN(THETP)/(4.*FOCAL*TAN(THETE/2.)+DM*COS(THETP)))
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 6
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=SIN(THETP-THETO)*(ALM-2.*FOCAL/(1.+COS(THETO)))/(2.*SIN(ALPHA))
C  ------- Equation 7
C  A	   SR ellipsoidal parameter
      A=FS/EC
C  ------- Equation 10
C  ALS	   Distance between focal point F(0) and P(0) on SR (feed to SR)
      ALS=2.*A-ALM+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGEO5(DM,DSRMR,THETE,THETP,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,ALS,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 5
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  FOCAL  MR focal length (negative)
C
C  Outputs:
C
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 18
C  ALPHA   (radians) Tilt angle between SR coordinate system Zsr-axis
C	   and feed coordinate system Zf-axis
      ALPHA=ATAN(DM*SIN(THETP)/(4.*FOCAL*TAN(THETE/2.)+DM*COS(THETP)))
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 20
C  A	   SR ellipsoidal parameter
      A=(DSRMR+HT+DM/2.)/(2.*EC*SIN(BETA)-(EC**2-1.)*SIN(THETP-THETE)/
     1 (EC*COS(ALPHA-THETE)+1.))
C  ------- Equation 16
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=A*EC
C  ------- Equation 19
C  ALS	   Distance between focal point F(0) and P(0) on SR (feed to SR)
      ALS=-A*(EC**2-1.)/(EC*COS(ALPHA)+1.)
C  ------- Equation 17
C  ALM	   Distance between SR point P(0) and point Q(0) on MR
C	   distance between SR and MR
      ALM=2.*A-ALS+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGEO6(DM,DCLEAR,THETE,THETP,FOCAL,ALPHA,HT,THETO,
     1 THETU,THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,ALM,ALS,DSRMR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 6
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  DCLEAR Clearance between rays from feed point and MR top
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  FOCAL  MR focal length (negative)
C
C  Outputs:
C
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 18
C  ALPHA   (radians) Tilt angle between SR coordinate system Zsr-axis
C	   and feed coordinate system Zf-axis
      ALPHA=ATAN(DM*SIN(THETP)/(4.*FOCAL*TAN(THETE/2.)+DM*COS(THETP)))
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 21
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=(DCLEAR+HT+DM/2.-(((2.*HT+DM)/(16.*FOCAL))**2-FOCAL)*
     1 TAN(THETP-THETE))/(2.*SIN(BETA)-2.*COS(BETA)*TAN(THETP-THETE))
C  ------- Equation 7
C  A	   SR ellipsoidal parameter
      A=FS/EC
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 19
C  ALS	   Distance between focal point F(0) and P(0) on SR (feed to SR)
      ALS=-A*(EC**2-1.)/(EC*COS(ALPHA)+1.)
C  ------- Equation 17
C  ALM	   Distance between SR point P(0) and point Q(0) on MR
C	   distance between SR and MR
      ALM=2.*A-ALS+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGEO7(DM,THETP,ALPHA,ALS,ALM,FOCAL,HT,THETO,THETU,
     1 THETL,EC,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETE,DSRMR,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 7
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C
C  Outputs:
C
C  FOCAL  MR focal length (negative)
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 15
C  A	   SR ellipsoidal parameter
      A=-ALS*(EC*COS(ALPHA)+1.)/(EC**2-1.)
C  ------- Equation 22
C  FOCAL   MR focal length (negative)
      FOCAL=(ALS+ALM-2.*A)*(1.+COS(THETO))/2.
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 23
C  THETE   (radians) Angle between Zf-axis and edge of SR
      THETE=2.*ATAN(DM*SIN(BETA)/(4.*SIN(ALPHA)*FOCAL))
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 16
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=A*EC
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGEO8(DM,EC,THETE,ALPHA,ALS,FOCAL,HT,THETO,THETU,
     1 THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALM,DSRMR,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 8
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  EC	    SR eccentricity
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C
C  Outputs:
C
C  FOCAL  MR focal length (negative)
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 24
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=2.*ATAN((EC+1.)*TAN(ALPHA/2.)/(EC-1.))
C  ------- Equation 25
C  THETP   (radians) Tilt angle between MR coordinate system Zmr-axis
C	   and feed coordinate system Zf-axis
      THETP=BETA+ALPHA
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 3
C  FOCAL   MR focal length (negative)
      FOCAL=DM*SIN(BETA)/(4.*SIN(ALPHA)*TAN(THETE/2.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 15
C  A	   SR ellipsoidal parameter
      A=-ALS*(EC*COS(ALPHA)+1.)/(EC**2-1.)
C  ------- Equation 16
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=A*EC
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 17
C  ALM	   Distance between SR point P(0) and point Q(0) on MR
C	   distance between SR and MR
      ALM=2.*A-ALS+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGEO9(DM,DSX,THETE,THETP,ALPHA,FOCAL,HT,THETO,THETU,
     1 THETL,EC,A,FS,CSRX,CSRZ,DSY,DSZ,BETA,ALS,ALM,DSRMR,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 9
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C
C  Outputs:
C
C  FOCAL  MR focal length (negative)
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  EC	    SR eccentricity
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 1
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=THETP-ALPHA
C  ------- Equation 2
C  EC	   SR eccentricity
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  ------- Equation 3
C  FOCAL   MR focal length (negative)
      FOCAL=DM*SIN(BETA)/(4.*SIN(ALPHA)*TAN(THETE/2.))
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 26
C  A	   SR ellipsoidal parameter
      A=-DSX/((EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(ALPHA-THETE)+1.)
     1 +(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(ALPHA+THETE)+1.))
C  ------- Equation 16
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=A*EC
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 19
C  ALS	   Distance between focal point F(0) and P(0) on SR (feed to SR)
      ALS=-A*(EC**2-1.)/(EC*COS(ALPHA)+1.)
C  ------- Equation 17
C  ALM	   Distance between SR point P(0) and point Q(0) on MR
C	   distance between SR and MR
      ALM=2.*A-ALS+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 11
C  DSRMR   Minimum distance between SR edge P(2) and MR edge Q(1)
      DSRMR=2.*FS*SIN(BETA)+A*(EC**2-1)*SIN(THETP-THETE)/
     1 (EC*COS(PI+ALPHA-THETE)-1.)-HT-DM/2.
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

      SUBROUTINE ICASGE10(DM,EC,THETE,ALPHA,DSRMR,FOCAL,HT,THETO,THETU,
     1 THETL,A,FS,CSRX,CSRZ,DSX,DSY,DSZ,BETA,THETP,ALS,ALM,DCLEAR)
C
C  Inverse Cassegrain Dual Reflector Geometry Option 10
C
C  Ref: Christophe Granet, "Designing Classical Offset Inverse-
C	Cassegrain Dual-Reflector Antennas from Combinations of
C	Prescribed Parameters," IEEE AP Magazine June 2003
C
C  Inputs:
C
C  DM	    Main reflector aperture diameter in X-Y plane
C  EC	    SR eccentricity
C  THETE  (radians) Angle between Zf-axis and edge of SR
C  ALPHA  (radians) Tilt angle between SR coordinate system Zsr-axis
C	    and feed coordinate system Zf-axis
C  DSRMR  Minimum distance between SR edge P(2) and MR edge Q(1)
C
C  Outputs:
C
C  FOCAL  MR focal length (negative)
C  HT	    Offset of MR (distance between Q(0) on MR and MR coordinate
C	    system Zmr-axis
C  THETO  (radians)  Offset angle of MR
C  THETU  (radians)  Offset angle of top of MR
C  THETL  (radians)  Offset angle of bottom of MR
C  A	    SR ellipsoidal parameter
C  FS	    SR surface parameter (half the interfocal distance, FS=A*EC
C  CSRX   Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	Center of ellipse aperture in SR coordinate system Z-axis
C  DSX	Major axis of SR ellipsoid parallel to X-axis
C  DSY	Major axis of SR ellipsoid parallel to Y-axis
C  DSZ	Major axis of SR ellipsoid parallel to Z-axis
C  BETA   (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
C  THETP  (radians) Tilt angle between MR coordinate system Zmr-axis
C	    and feed coordinate system Zf-axis
C  ALS	Distance between focal point F(0) and P(0) on SR (feed to SR)
C  ALM	Distance between SR point P(0) and point Q(0) on MR
C	    distance between SR and MR
C  DCLEAR Clearance between rays from feed point and MR top
C
      DIMENSION XX(5)
      EXTERNAL DSYSF
      PI=2.*ACOS(0.)
C  ------- Equation 24
C  BETA    (radians) Tilt angle between SR Zrs-axis and MR Zmr-axis
      BETA=2.*ATAN((EC+1.)*TAN(ALPHA/2.)/(EC-1.))
C  ------- Equation 25
C  THETP   (radians) Tilt angle between MR coordinate system Zmr-axis
C	   and feed coordinate system Zf-axis
      THETP=BETA+ALPHA
C  ------- Equation 3
C  FOCAL   MR focal length (negative)
      FOCAL=DM*SIN(BETA)/(4.*SIN(ALPHA)*TAN(THETE/2.))
C  ------- Equation 4
C  THETO   (radians)  Offset angle of MR
      THETO=BETA-2.*ATAN((EC-1.)*TAN(ALPHA/2.)/(EC+1.))
C  ------- Equation 5
C  HT	   Offset of MR (distance between Q(0) on MR and MR coordinate
C	   system Zmr-axis
      HT=-2.*FOCAL*TAN(THETO/2.)
C  ------- Equation 20
C  A	   SR ellipsoidal parameter
      A=(DSRMR+HT+DM/2.)/(2.*EC*SIN(BETA)-(EC**2-1.)*SIN(THETP-THETE)/
     1 (EC*COS(ALPHA-THETE)+1.))
C  ------- Equation 16
C  FS	   SR surface parameter (half the interfocal distance, FS=A*EC
      FS=A*EC
C  ------- Equation 8
C  THETU   (radians)  Offset angle of top of MR
      THETU=-2*ATAN((2.*HT+DM)/(4.*FOCAL))
C  ------- Equation 9
C  THETL   (radians)  Offset angle of bottom of MR
      THETL=-2*ATAN((2.*HT-DM)/(4.*FOCAL))
C  ------- Equation 19
C  ALS	   Distance between focal point F(0) and P(0) on SR (feed to SR)
      ALS=-A*(EC**2-1.)/(EC*COS(ALPHA)+1.)
C  ------- Equation 17
C  ALM	   Distance between SR point P(0) and point Q(0) on MR
C	   distance between SR and MR
      ALM=2.*A-ALS+2.*FOCAL/(1.+COS(THETO))
C  ------- Equation 12
C  DCLEAR  Clearance between rays from feed point and MR top
      DXFMR=2.*FS*SIN(BETA)-HT-DM/2.
      DZFMR=2.*FS*COS(BETA)-(2.*HT+DM)**2/16./FOCAL+FOCAL
      DCLEAR=DXFMR-DZFMR*TAN(THETP-THETE)
C  ------- Equation 14
C  CSRX    Center of ellipse aperture in SR coordinate system X-axis
C  CSRZ	   Center of ellipse aperture in SR coordinate system Z-axis
      CSRX=(A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 -A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.))/2.
      CSRZ=-(A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 +A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     2 +4.*FS)/2.
C  ------- Equation 13
C  DSX	   Major axis of SR ellipsoid parallel to X-axis
      DSX=A*(EC**2-1.)*SIN(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
     1 +A*(EC**2-1.)*SIN(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
C  ------- Equation 27
C  DSY	   Major axis of SR ellipsoid parallel to Y-axis
C
C  Search for maximum
      XX(2)=A
      XX(3)=EC
      XX(4)=THETE
      XX(5)=ALPHA
      DSYMAX=0.
      DO 1 I=1,11
      XX(1)=FLOAT(I-1)*PI/5.
      DSYT=DSYSF(XX)
      IF(DSYT.GT.DSYMAX)THEN
      DSYMAX=DSYT
      XXC=XX(1)
      ENDIF
    1 CONTINUE
      AP=XXC-PI/10.
      BP=XXC+PI/10.
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,DSYSF,RT)
      DSY=AMAX1(FA,FB)
C  ------- Equation 28
C  DSZ	   Major axis of SR ellipsoid parallel to Z-axis
      DSZ=A*(EC**2-1.)*COS(THETE+ALPHA)/(EC*COS(PI+ALPHA+THETE)-1.)
     1 -A*(EC**2-1.)*COS(THETE-ALPHA)/(EC*COS(PI+ALPHA-THETE)-1.)
      RETURN
      END

