      PROGRAMS GRANETD
C
C  Design equations for Classical Dragonian Offset Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, pp. 100 - 107 Dec 01
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
      DIMENSION CSR(3)
      TR=ACOS(0.)/90.
      OPEN(66,FILE='granetd.out')
C  ---------- Example 1
      DM=100.
      FTILT=-170.
      WRITE(66,1)DM,FTILT
    1 FORMAT(' Example 1.',/,
     1' Main reflector diameter:           ',F8.3,/,
     2' Tilt between MR and feed axis:     ',F8.2,/)
      FTILT=FTILT*TR
      OFFSA=-80.
      DISTM=100.
      FEA=30.
      WRITE(66,2)OFFSA,DISTM,FEA
    2 FORMAT(' Option 1 Design Inputs:',/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      OFFSA=OFFSA*TR
      FEA=FEA*TR
C  -------- Option 1
      CALL DRAGEO1(DM,OFFSA,DISTM,FEA,FTILT,FOCAL,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
      WRITE(66,3)FOCAL,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),CSR(3),
     1DSX,DSY,BETA/TR,DISTS,DFMR,DSRMR
    3 FORMAT(' Outputs:'/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 2
      FOCAL=100.693
      WRITE(66,4)FOCAL,DISTM,FEA/TR
    4 FORMAT(/,' Option 2 Design Inputs:',/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      CALL DRAGEO2(DM,FOCAL,DISTM,FEA,FTILT,OFFSA,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
      WRITE(66,5)OFFSA/TR,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),
     1 CSR(3),DSX,DSY,BETA/TR,DISTS,DFMR,DSRMR
    5 FORMAT(' Outputs:'/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 3
      DISTS=38.927
      WRITE(66,6)FOCAL,DISTS,FEA/TR
    6 FORMAT(/,' Option 3 Design Inputs:',/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      CALL DRAGEO3(DM,FOCAL,DISTS,FEA,FTILT,OFFSA,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTM,DFMR,DSRMR)
      WRITE(66,7)OFFSA/TR,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),
     1 CSR(3),DSX,DSY,BETA/TR,DISTM,DFMR,DSRMR
    7 FORMAT(' Outputs:'/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 4
      DISTS=38.927
      OFFSA=-80.
      WRITE(66,8)OFFSA,DISTS,FEA/TR
    8 FORMAT(/,' Option 4 Design Inputs:',/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      OFFSA=OFFSA*TR
      CALL DRAGEO4(DM,OFFSA,DISTS,FEA,FTILT,FOCAL,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTM,DFMR,DSRMR)
      WRITE(66,9)FOCAL,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),
     1 CSR(3),DSX,DSY,BETA/TR,DISTM,DFMR,DSRMR
    9 FORMAT(' Outputs:'/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 5
      DISTM=100.
      DISTS=38.927
      OFFSA=-80.
      WRITE(66,10)OFFSA,DISTM,DISTS
   10 FORMAT(/,' Option 5 Design Inputs:',/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3)
      OFFSA=OFFSA*TR
      CALL DRAGEO5(DM,OFFSA,DISTM,FEA,FTILT,FOCAL,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
      WRITE(66,11)FOCAL,OFFH,THETU/TR,THETL/TR,FEA/TR,EC,AH,SUBF,
     1 CSR(1),CSR(3),DSX,DSY,BETA/TR,DFMR,DSRMR
   11 FORMAT(' Outputs:'/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     3' Feed half subtended angle:         ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  ---------- Example 2
      DM=100.
      FTILT=-90.
      WRITE(66,12)DM,FTILT
   12 FORMAT(//,' Example 2.',/,
     1' Main reflector diameter:           ',F8.3,/,
     2' Tilt between MR and feed axis:     ',F8.2,/)
      FTILT=FTILT*TR
      OFFSA=-50.
      DISTM=100.
      FEA=15.
      WRITE(66,13)OFFSA,DISTM,FEA
   13 FORMAT(' Option 1 Design Inputs:',/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      OFFSA=OFFSA*TR
      FEA=FEA*TR
C  -------- Option 1
      CALL DRAGEO1(DM,OFFSA,DISTM,FEA,FTILT,FOCAL,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
      WRITE(66,14)FOCAL,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),CSR(3),
     1DSX,DSY,BETA/TR,DISTS,DFMR,DSRMR
   14 FORMAT(' Outputs:'/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 2
      FOCAL=355.811
      WRITE(66,15)FOCAL,DISTM,FEA/TR
   15 FORMAT(/,' Option 2 Design Inputs:',/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      CALL DRAGEO2(DM,FOCAL,DISTM,FEA,FTILT,OFFSA,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
      WRITE(66,16)OFFSA/TR,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),
     1 CSR(3),DSX,DSY,BETA/TR,DISTS,DFMR,DSRMR
   16 FORMAT(' Outputs:'/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 3
      DISTS=146.057
      WRITE(66,17)FOCAL,DISTS,FEA/TR
   17 FORMAT(/,' Option 3 Design Inputs:',/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      CALL DRAGEO3(DM,FOCAL,DISTS,FEA,FTILT,OFFSA,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTM,DFMR,DSRMR)
      WRITE(66,18)OFFSA/TR,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),
     1 CSR(3),DSX,DSY,BETA/TR,DISTM,DFMR,DSRMR
   18 FORMAT(' Outputs:'/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 4
      DISTS=146.057
      OFFSA=-50.
      WRITE(66,19)OFFSA,DISTS,FEA/TR
   19 FORMAT(/,' Option 4 Design Inputs:',/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Ls  feed to subreflector:          ',F8.3,/,
     3' Feed half subtended angle:         ',F8.2)
      OFFSA=OFFSA*TR
      CALL DRAGEO4(DM,OFFSA,DISTS,FEA,FTILT,FOCAL,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTM,DFMR,DSRMR)
      WRITE(66,20)FOCAL,OFFH,THETU/TR,THETL/TR,EC,AH,SUBF,CSR(1),
     1 CSR(3),DSX,DSY,BETA/TR,DISTM,DFMR,DSRMR
   20 FORMAT(' Outputs:'/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
C  -------- Option 5
      DISTM=100.
      DISTS=146.057
      OFFSA=-50.
      WRITE(66,21)OFFSA,DISTM,DISTS
   21 FORMAT(/,' Option 5 Design Inputs:',/,
     1' Offset angle of main reflector:    ',F8.2,/,
     2' Lm Distance from SR Po to MR Qo:   ',F8.3,/,
     2' Ls  feed to subreflector:          ',F8.3)
      OFFSA=OFFSA*TR
      CALL DRAGEO5(DM,OFFSA,DISTM,FEA,FTILT,FOCAL,OFFH,THETU,THETL,
     1 EC,AH,SUBF,CSR,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
      WRITE(66,22)FOCAL,OFFH,THETU/TR,THETL/TR,FEA/TR,EC,AH,SUBF,
     1 CSR(1),CSR(3),DSX,DSY,BETA/TR,DFMR,DSRMR
   22 FORMAT(' Outputs:'/,
     1' Main Reflector focal length:       ',F8.3,/,
     2' Main Reflector Center Offset:      ',F8.3,/,
     3' MR top edge offset angle:          ',F8.2,/,
     4' MR bottom edge offset angle:       ',F8.2,/,
     3' Feed half subtended angle:         ',F8.2,/,
     5' Subreflector eccentricity:         ',F8.3,/,
     6' Subreflector parameter a:          ',F8.3,/,
     7' SR half interfocal distance:       ',F8.3,/,
     8' Center of approx. SR ellipse:      ',F8.3,F9.3,/,
     9' Major axis of SR ellipse DSX:      ',F8.3,/,
     1' Minor axis of SR ellipse DSY:      ',F8.3,/,
     1' Beta Tilt between SR and MR coord: ',F8.3,/,
     3' Df-mr  Fo and upper point:         ',F8.3,/,
     4' Dsr-mr  Fo to lower point:         ',F8.3)
      END
      SUBROUTINE DRAGEO1(DM,OFFSA,DISTM,FEA,FTILT,FOCAL,OFFH,THETU,
     1 THETL,EC,AH,SUBF,CRM,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
C
C  Option 1 Dragonian Offset Dual-Reflector Geometry
C
C  Design equations for Classical Dragonian Offset Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, pp. 100 - 107 Dec 01
C
C  Equations by Christophe Granet
C
C  Inputs:
C
C  DM	    Main reflector diameter
C  OFFSA  Offset angle of the main reflector
C  DISTM  Distance between the Subreflector point Po along central
C	    ray and Qo the central ray point on main reflector
C	    (Distance between subreflector and main reflector)
C  FEA	Feed half subtended angle between Zf axis and the edge of
C	    the subreflector
C  FTILT  Tilt angle between the main reflector coordinate system
C	    Zmr axis and the feed coordinate system Zf-axis
C
C  Outputs:
C
C  FOCAL  Main reflector focal length
C  OFFH   Offset of the center of the main reflector
C  THETU  Offset angle of the top of the main reflector
C  THETL  Offset angle of the bottom of the main reflector
C  EC	    Subreflector eccentricity
C  AH	    Subreflector radial parameter
C  SUBF   Subreflector half interfocal distance
C  CRM	Point expressed in the main reflector coordinate system
C	    defining the center of the approximated elliptical aperture
C  DSX	Major axis of the subreflector approximated elliptical
C	    aperture parallel to the X-sr axis
C  DSY	Minor axis of the subreflector approximated elliptical
C	    aperture parallel to the Y-sr axis
C  BETA   Tilt angle between the subreflector coordinate system Zsr axis
C	    and the main reflector coordinate system Zmr axis
C  DISTS  Distance along central ray between focal point and Po on the
C	    subreflector (distance between feed and subreflector)
C  DFMR   Minimum vertical distance between the feed (Fo) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C  DSRMR  Minimum vertical distance between SR edges (P1,P2) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C
C  All angles radians
C
      DIMENSION P1(3),P2(3),FO(3),CSR(3),CRM(3),CMR(3),XX(5)
      EXTERNAL SUMDIA
      PI=2.*ACOS(0.)
C  -------- Equation 3
      TBETA=2.*SIN(FTILT/2.)**2*COS(OFFSA/2.)/(SIN(FTILT)*COS(OFFSA/2.)
     1 -SIN(OFFSA/2.))
      BETA=FTILT/2.+ATAN(SIN(FTILT/2.)*SIN(OFFSA/2.)/(SIN((FTILT-OFFSA)
     1/2.)+SIN(FTILT/2.)*COS(OFFSA/2.)))
C  -------- Equation 4
      ALPHA=FTILT-BETA
C  -------- Equation 6
      FOCAL=DM*SIN(BETA)/(4.*TAN(FEA/2.)*SIN(FTILT-BETA))
C  -------- Equation 12
      OFFH=2.*FOCAL*TAN(-OFFSA/2.)
C  -------- Equation 13
      DISTS=SIN(BETA-OFFSA)/SIN(ALPHA)*(OFFH/SIN(ABS(OFFSA))-DISTM)
C  -------- Equation 14
      AH=OFFH/(2.*SIN(ABS(OFFSA)))-(DISTM+DISTS)/2.
C  -------- Equation 5
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  -------- Equation 15
      SUBF=AH*EC
C  -------- Equation 8
      PAR=2.*FOCAL*TAN(OFFSA/2.)-2.*SUBF*SIN(BETA)
      DFMR=ABS(PAR)-DISTM/2.
C  -------- Equation 20
      THETU=-2.*ATAN((OFFH+DISTM/2.)/(2.*FOCAL))
C  -------- Equation 21
      THETL=-2.*ATAN((OFFH-DISTM/2.)/(2.*FOCAL))
C  -------- Equation 9
      AA=ABS(ALPHA)
      PF1=2.*SUBF*SIN(AA-FEA)/SIN(PI-ABS(AA-FEA)-ABS(ABS(BETA)
     1 -ABS(THETU)))
      PF2=2.*SUBF*SIN(AA+FEA)/SIN(PI-ABS(AA+FEA)-ABS(ABS(BETA)
     1 -ABS(THETL)))
      P1(1)=-PF1*SIN(THETU)
      P1(2)=0.
      P1(3)=-PF1*COS(THETU)
      P2(1)=-PF2*SIN(THETL)
      P2(2)=0.
      P2(3)=-PF2*COS(THETL)
      DSR1=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA+FEA)+1.)*SIN(FTILT+FEA)-DISTM/2.
      DSR2=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA-FEA)+1.)*SIN(FTILT-FEA)-DISTM/2.
      DSRMR=AMIN1(DSR1,DSR2)
C  -------- Equation 22
      FO(1)=2.*SUBF*COS(BETA+PI/2.)
      FO(2)=0.
      FO(3)=-2.*SUBF*SIN(BETA+PI/2.)
      FOP1=SQRT((FO(1)-P1(1))**2+(FO(3)-P1(3))**2)
      FOP2=SQRT((FO(1)-P2(1))**2+(FO(3)-P2(3))**2)
      DSX=FOP1*SIN(ALPHA+FEA)-FOP2*SIN(ALPHA-FEA)
C  -------- Equation 23
      CSR(1)=(FOP1*SIN(ALPHA+FEA)+FOP2*SIN(ALPHA-FEA))/2.
      CSR(2)=0.
      CSR(3)=-AH*SQRT(1.+CSR(1)**2/(SUBF**2-AH**2))-SUBF
C  -------- Equation 24
      CRM(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CRM(2)=0.
      CRM(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      THETC=ATAN(CRM(1)/CRM(3))
      OCMR=2.*FOCAL/(1.+COS(THETC))
      CMR(1)=-OCMR*SIN(THETC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THETC)
C  -------- DC distance of the MR aperture at a height Xcmr while the
C	    projected aperture of MR on the (0,x,y) plane is a circle DM
      DC=DM*SQRT(1.-4.*(CMR(1)-OFFH)**2/DM**2)
      XX(2)=EC
      XX(3)=AH
      XX(4)=FEA
      XX(5)=ALPHA
      AP=0.
      BP=2.*PI
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
C	   and the feed coordinate system Zf-axis
C
      DIMENSION X(5)
      SUMDIA=2.*X(3)*(X(2)**2-1.)*SIN(X(4))*SIN(X(1))/(X(2)*(-SIN(X(5))
     1*SIN(X(4))*COS(X(1))+COS(X(5))*COS(X(4)))+1.)
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
      SUBROUTINE DRAGEO2(DM,FOCAL,DISTM,FEA,FTILT,OFFSA,OFFH,THETU,
     1 THETL,EC,AH,SUBF,CRM,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
C
C  Option 2 Dragonian Offset Dual-Reflector Geometry
C
C  Design equations for Classical Dragonian Offset Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, pp. 100 - 107 Dec 01
C
C  Equations by Christophe Granet
C
C  Inputs:
C
C  DM	    Main reflector diameter
C  FOCAL  Main reflector focal length
C  DISTM  Distance between the Subreflector point Po along central
C	    ray and Qo the central ray point on main reflector
C	    (Distance between subreflector and main reflector)
C  FEA	Feed half subtended angle between Zf axis and the edge of
C	    the subreflector
C  FTILT  Tilt angle between the main reflector coordinate system
C	    Zmr axis and the feed coordinate system Zf-axis
C
C  Outputs:
C
C  OFFSA  Offset angle of the main reflector
C  OFFH   Offset of the center of the main reflector
C  THETU  Offset angle of the top of the main reflector
C  THETL  Offset angle of the bottom of the main reflector
C  EC	    Subreflector eccentricity
C  AH	    Subreflector radial parameter
C  SUBF   Subreflector half interfocal distance
C  CRM	Point expressed in the main reflector coordinate system
C	    defining the center of the approximated elliptical aperture
C  DSX	Major axis of the subreflector approximated elliptical
C	    aperture parallel to the X-sr axis
C  DSY	Minor axis of the subreflector approximated elliptical
C	    aperture parallel to the Y-sr axis
C  BETA   Tilt angle between the subreflector coordinate system Zsr axis
C	    and the main reflector coordinate system Zmr axis
C  DISTS  Distance along central ray between focal point and Po on the
C	    subreflector (distance between feed and subreflector)
C  DFMR   Minimum vertical distance between the feed (Fo) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C  DSRMR  Minimum vertical distance between SR edges (P1,P2) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C
C  All angles radians
C
      DIMENSION P1(3),P2(3),FO(3),CSR(3),CRM(3),CMR(3),XX(5)
      EXTERNAL SUMDIA
      PI=2.*ACOS(0.)
C  -------- Equation 10
      TBETA=4.*FOCAL*TAN(FEA/2.)*SIN(FTILT)/(DM+4.*FOCAL
     1*TAN(FEA/2.)*COS(FTILT))
      BETA=ATAN(TBETA)
      IF(TBETA.GT.0.)BETA=BETA-PI
C  -------- Equation 4
      ALPHA=FTILT-BETA
C  -------- Equation 5
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  -------- Equation 11
      TOFFH=TAN(BETA/2.)*(((EC+1.)/(EC-1.))**2-1.)/(TAN(BETA/2.)**2
     1 +((EC+1.)/(EC-1.))**2)
      OFFSA=2.*ATAN(TOFFH)
C  -------- Equation 12
      OFFH=2.*FOCAL*TAN(-OFFSA/2.)
C  -------- Equation 20
      THETU=-2.*ATAN((OFFH+DISTM/2.)/(2.*FOCAL))
C  -------- Equation 21
      THETL=-2.*ATAN((OFFH-DISTM/2.)/(2.*FOCAL))
C  -------- Equation 13
      DISTS=SIN(BETA-OFFSA)/SIN(ALPHA)*(OFFH/SIN(ABS(OFFSA))-DISTM)
C  -------- Equation 14
      AH=OFFH/(2.*SIN(ABS(OFFSA)))-(DISTM+DISTS)/2.
C  -------- Equation 15
      SUBF=AH*EC
C  -------- Equation 8
      PAR=2.*FOCAL*TAN(OFFSA/2.)-2.*SUBF*SIN(BETA)
      DFMR=ABS(PAR)-DISTM/2.
C  -------- Equation 9
      AA=ABS(ALPHA)
      PF1=2.*SUBF*SIN(AA-FEA)/SIN(PI-ABS(AA-FEA)-ABS(ABS(BETA)
     1 -ABS(THETU)))
      PF2=2.*SUBF*SIN(AA+FEA)/SIN(PI-ABS(AA+FEA)-ABS(ABS(BETA)
     1 -ABS(THETL)))
      P1(1)=-PF1*SIN(THETU)
      P1(2)=0.
      P1(3)=-PF1*COS(THETU)
      P2(1)=-PF2*SIN(THETL)
      P2(2)=0.
      P2(3)=-PF2*COS(THETL)
      DSR1=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA+FEA)+1.)*SIN(FTILT+FEA)-DISTM/2.
      DSR2=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA-FEA)+1.)*SIN(FTILT-FEA)-DISTM/2.
      DSRMR=AMIN1(DSR1,DSR2)
C  -------- Equation 22
      FO(1)=2.*SUBF*COS(BETA+PI/2.)
      FO(2)=0.
      FO(3)=-2.*SUBF*SIN(BETA+PI/2.)
      FOP1=SQRT((FO(1)-P1(1))**2+(FO(3)-P1(3))**2)
      FOP2=SQRT((FO(1)-P2(1))**2+(FO(3)-P2(3))**2)
      DSX=FOP1*SIN(ALPHA+FEA)-FOP2*SIN(ALPHA-FEA)
C  -------- Equation 23
      CSR(1)=(FOP1*SIN(ALPHA+FEA)+FOP2*SIN(ALPHA-FEA))/2.
      CSR(2)=0.
      CSR(3)=-AH*SQRT(1.+CSR(1)**2/(SUBF**2-AH**2))-SUBF
C  -------- Equation 24
      CRM(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CRM(2)=0.
      CRM(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      THETC=ATAN(CRM(1)/CRM(3))
      OCMR=2.*FOCAL/(1.+COS(THETC))
      CMR(1)=-OCMR*SIN(THETC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THETC)
C  -------- DC distance of the MR aperture at a height Xcmr while the
C	    projected aperture of MR on the (0,x,y) plane is a circle DM
      DC=DM*SQRT(1.-4.*(CMR(1)-OFFH)**2/DM**2)
      XX(2)=EC
      XX(3)=AH
      XX(4)=FEA
      XX(5)=ALPHA
      AP=0.
      BP=2.*PI
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END
      SUBROUTINE DRAGEO3(DM,FOCAL,DISTS,FEA,FTILT,OFFSA,OFFH,THETU,
     1 THETL,EC,AH,SUBF,CRM,DSX,DSY,BETA,DISTM,DFMR,DSRMR)
C
C  Option 3 Dragonian Offset Dual-Reflector Geometry
C
C  Design equations for Classical Dragonian Offset Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, pp. 100 - 107 Dec 01
C
C  Equations by Christophe Granet
C
C  Inputs:
C
C  DM	    Main reflector diameter
C  FOCAL  Main reflector focal length
C  FEA    Feed half subtended angle between Zf axis and the edge of
C	    the subreflector
C  DISTS  Distance along central ray between focal point and Po on the
C	    subreflector (distance between feed and subreflector)
C  FTILT  Tilt angle between the main reflector coordinate system
C	    Zmr axis and the feed coordinate system Zf-axis
C
C  Outputs:
C
C  OFFSA  Offset angle of the main reflector
C  OFFH   Offset of the center of the main reflector
C  THETU  Offset angle of the top of the main reflector
C  THETL  Offset angle of the bottom of the main reflector
C  EC	    Subreflector eccentricity
C  AH	    Subreflector radial parameter
C  SUBF   Subreflector half interfocal distance
C  CRM	Point expressed in the main reflector coordinate system
C	    defining the center of the approximated elliptical aperture
C  DSX	Major axis of the subreflector approximated elliptical
C	    aperture parallel to the X-sr axis
C  DSY	Minor axis of the subreflector approximated elliptical
C	    aperture parallel to the Y-sr axis
C  BETA   Tilt angle between the subreflector coordinate system Zsr axis
C	    and the main reflector coordinate system Zmr axis
C  DISTM  Distance between the Subreflector point Po along central
C	    ray and Qo the central ray point on main reflector
C	    (Distance between subreflector and main reflector)
C  DFMR   Minimum vertical distance between the feed (Fo) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C  DSRMR  Minimum vertical distance between SR edges (P1,P2) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C
C  All angles radians
C
      DIMENSION P1(3),P2(3),FO(3),CSR(3),CRM(3),CMR(3),XX(5)
      EXTERNAL SUMDIA
      PI=2.*ACOS(0.)
C  -------- Equation 10
      TBETA=4.*FOCAL*TAN(FEA/2.)*SIN(FTILT)/(DM+4.*FOCAL
     1*TAN(FEA/2.)*COS(FTILT))
      BETA=ATAN(TBETA)
      IF(TBETA.GT.0.)BETA=BETA-PI
C  -------- Equation 4
      ALPHA=FTILT-BETA
C  -------- Equation 5
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  -------- Equation 11
      TOFFH=TAN(BETA/2.)*(((EC+1.)/(EC-1.))**2-1.)/(TAN(BETA/2.)**2
     1 +((EC+1.)/(EC-1.))**2)
      OFFSA=2.*ATAN(TOFFH)
C  -------- Equation 12
      OFFH=2.*FOCAL*TAN(-OFFSA/2.)
C  -------- Equation 20
      THETU=-2.*ATAN((OFFH+DISTM/2.)/(2.*FOCAL))
C  -------- Equation 21
      THETL=-2.*ATAN((OFFH-DISTM/2.)/(2.*FOCAL))
C  -------- Equation 16
      DISTM=OFFH/SIN(ABS(OFFSA))-DISTS*SIN(ALPHA)/SIN(BETA-OFFSA)
C  -------- Equation 14
      AH=OFFH/(2.*SIN(ABS(OFFSA)))-(DISTM+DISTS)/2.
C  -------- Equation 15
      SUBF=AH*EC
C  -------- Equation 8
      PAR=2.*FOCAL*TAN(OFFSA/2.)-2.*SUBF*SIN(BETA)
      DFMR=ABS(PAR)-DISTM/2.
C  -------- Equation 9
      AA=ABS(ALPHA)
      PF1=2.*SUBF*SIN(AA-FEA)/SIN(PI-ABS(AA-FEA)-ABS(ABS(BETA)
     1 -ABS(THETU)))
      PF2=2.*SUBF*SIN(AA+FEA)/SIN(PI-ABS(AA+FEA)-ABS(ABS(BETA)
     1 -ABS(THETL)))
      P1(1)=-PF1*SIN(THETU)
      P1(2)=0.
      P1(3)=-PF1*COS(THETU)
      P2(1)=-PF2*SIN(THETL)
      P2(2)=0.
      P2(3)=-PF2*COS(THETL)
      DSR1=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA+FEA)+1.)*SIN(FTILT+FEA)-DISTM/2.
      DSR2=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA-FEA)+1.)*SIN(FTILT-FEA)-DISTM/2.
      DSRMR=AMIN1(DSR1,DSR2)
C  -------- Equation 22
      FO(1)=2.*SUBF*COS(BETA+PI/2.)
      FO(2)=0.
      FO(3)=-2.*SUBF*SIN(BETA+PI/2.)
      FOP1=SQRT((FO(1)-P1(1))**2+(FO(3)-P1(3))**2)
      FOP2=SQRT((FO(1)-P2(1))**2+(FO(3)-P2(3))**2)
      DSX=FOP1*SIN(ALPHA+FEA)-FOP2*SIN(ALPHA-FEA)
C  -------- Equation 23
      CSR(1)=(FOP1*SIN(ALPHA+FEA)+FOP2*SIN(ALPHA-FEA))/2.
      CSR(2)=0.
      CSR(3)=-AH*SQRT(1.+CSR(1)**2/(SUBF**2-AH**2))-SUBF
C  -------- Equation 24
      CRM(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CRM(2)=0.
      CRM(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      THETC=ATAN(CRM(1)/CRM(3))
      OCMR=2.*FOCAL/(1.+COS(THETC))
      CMR(1)=-OCMR*SIN(THETC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THETC)
C  -------- DC distance of the MR aperture at a height Xcmr while the
C	    projected aperture of MR on the (0,x,y) plane is a circle DM
      DC=DM*SQRT(1.-4.*(CMR(1)-OFFH)**2/DM**2)
      XX(2)=EC
      XX(3)=AH
      XX(4)=FEA
      XX(5)=ALPHA
      AP=0.
      BP=2.*PI
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END
      SUBROUTINE DRAGEO4(DM,OFFSA,DISTS,FEA,FTILT,FOCAL,OFFH,THETU,
     1 THETL,EC,AH,SUBF,CRM,DSX,DSY,BETA,DISTM,DFMR,DSRMR)
C
C  Option 4 Dragonian Offset Dual-Reflector Geometry
C
C  Design equations for Classical Dragonian Offset Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, pp. 100 - 107 Dec 01
C
C  Equations by Christophe Granet
C
C  Inputs:
C
C  DM	    Main reflector diameter
C  OFFSA  Offset angle of the main reflector
C  FEA    Feed half subtended angle between Zf axis and the edge of
C	    the subreflector
C  DISTS  Distance along central ray between focal point and Po on the
C	    subreflector (distance between feed and subreflector)
C  FTILT  Tilt angle between the main reflector coordinate system
C	    Zmr axis and the feed coordinate system Zf-axis
C
C  Outputs:
C
C  FOCAL  Main reflector focal length
C  OFFH   Offset of the center of the main reflector
C  THETU  Offset angle of the top of the main reflector
C  THETL  Offset angle of the bottom of the main reflector
C  EC	    Subreflector eccentricity
C  AH	    Subreflector radial parameter
C  SUBF   Subreflector half interfocal distance
C  CRM	Point expressed in the main reflector coordinate system
C	    defining the center of the approximated elliptical aperture
C  DSX	Major axis of the subreflector approximated elliptical
C	    aperture parallel to the X-sr axis
C  DSY	Minor axis of the subreflector approximated elliptical
C	    aperture parallel to the Y-sr axis
C  BETA   Tilt angle between the subreflector coordinate system Zsr axis
C	    and the main reflector coordinate system Zmr axis
C  DISTM  Distance between the Subreflector point Po along central
C	    ray and Qo the central ray point on main reflector
C	    (Distance between subreflector and main reflector)
C  DFMR   Minimum vertical distance between the feed (Fo) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C  DSRMR  Minimum vertical distance between SR edges (P1,P2) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C
C  All angles radians
C
      DIMENSION P1(3),P2(3),FO(3),CSR(3),CRM(3),CMR(3),XX(5)
      EXTERNAL SUMDIA
      PI=2.*ACOS(0.)
C  -------- Equation 3
      TBETA=2.*SIN(FTILT/2.)**2*COS(OFFSA/2.)/(SIN(FTILT)*COS(OFFSA/2.)
     1 -SIN(OFFSA/2.))
      BETA=FTILT/2.+ATAN(SIN(FTILT/2.)*SIN(OFFSA/2.)/(SIN((FTILT-OFFSA)
     1/2.)+SIN(FTILT/2.)*COS(OFFSA/2.)))
C  -------- Equation 4
      ALPHA=FTILT-BETA
C  -------- Equation 5
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  -------- Equation 6
      FOCAL=DM*SIN(BETA)/(4.*TAN(FEA/2.)*SIN(FTILT-BETA))
C  -------- Equation 12
      OFFH=2.*FOCAL*TAN(-OFFSA/2.)
C  -------- Equation 16
      DISTM=OFFH/SIN(ABS(OFFSA))-DISTS*SIN(ALPHA)/SIN(BETA-OFFSA)
C  -------- Equation 14
      AH=OFFH/(2.*SIN(ABS(OFFSA)))-(DISTM+DISTS)/2.
C  -------- Equation 15
      SUBF=AH*EC
C  -------- Equation 20
      THETU=-2.*ATAN((OFFH+DISTM/2.)/(2.*FOCAL))
C  -------- Equation 21
      THETL=-2.*ATAN((OFFH-DISTM/2.)/(2.*FOCAL))
C  -------- Equation 8
      PAR=2.*FOCAL*TAN(OFFSA/2.)-2.*SUBF*SIN(BETA)
      DFMR=ABS(PAR)-DISTM/2.
C  -------- Equation 9
      AA=ABS(ALPHA)
      PF1=2.*SUBF*SIN(AA-FEA)/SIN(PI-ABS(AA-FEA)-ABS(ABS(BETA)
     1 -ABS(THETU)))
      PF2=2.*SUBF*SIN(AA+FEA)/SIN(PI-ABS(AA+FEA)-ABS(ABS(BETA)
     1 -ABS(THETL)))
      P1(1)=-PF1*SIN(THETU)
      P1(2)=0.
      P1(3)=-PF1*COS(THETU)
      P2(1)=-PF2*SIN(THETL)
      P2(2)=0.
      P2(3)=-PF2*COS(THETL)
      DSR1=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA+FEA)+1.)*SIN(FTILT+FEA)-DISTM/2.
      DSR2=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA-FEA)+1.)*SIN(FTILT-FEA)-DISTM/2.
      DSRMR=AMIN1(DSR1,DSR2)
C  -------- Equation 22
      FO(1)=2.*SUBF*COS(BETA+PI/2.)
      FO(2)=0.
      FO(3)=-2.*SUBF*SIN(BETA+PI/2.)
      FOP1=SQRT((FO(1)-P1(1))**2+(FO(3)-P1(3))**2)
      FOP2=SQRT((FO(1)-P2(1))**2+(FO(3)-P2(3))**2)
      DSX=FOP1*SIN(ALPHA+FEA)-FOP2*SIN(ALPHA-FEA)
C  -------- Equation 23
      CSR(1)=(FOP1*SIN(ALPHA+FEA)+FOP2*SIN(ALPHA-FEA))/2.
      CSR(2)=0.
      CSR(3)=-AH*SQRT(1.+CSR(1)**2/(SUBF**2-AH**2))-SUBF
C  -------- Equation 24
      CRM(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CRM(2)=0.
      CRM(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      THETC=ATAN(CRM(1)/CRM(3))
      OCMR=2.*FOCAL/(1.+COS(THETC))
      CMR(1)=-OCMR*SIN(THETC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THETC)
C  -------- DC distance of the MR aperture at a height Xcmr while the
C	    projected aperture of MR on the (0,x,y) plane is a circle DM
      DC=DM*SQRT(1.-4.*(CMR(1)-OFFH)**2/DM**2)
      XX(2)=EC
      XX(3)=AH
      XX(4)=FEA
      XX(5)=ALPHA
      AP=0.
      BP=2.*PI
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END
      SUBROUTINE DRAGEO5(DM,OFFSA,DISTM,FEA,FTILT,FOCAL,OFFH,THETU,
     1 THETL,EC,AH,SUBF,CRM,DSX,DSY,BETA,DISTS,DFMR,DSRMR)
C
C  Option 5 Dragonian Offset Dual-Reflector Geometry
C
C  Design equations for Classical Dragonian Offset Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, pp. 100 - 107 Dec 01
C
C  Equations by Christophe Granet
C
C  Inputs:
C
C  DM	    Main reflector diameter
C  OFFSA  Offset angle of the main reflector
C  DISTM  Distance between the Subreflector point Po along central
C	    ray and Qo the central ray point on main reflector
C	    (Distance between subreflector and main reflector)
C  DISTS  Distance along central ray between focal point and Po on the
C	    subreflector (distance between feed and subreflector)
C  FTILT  Tilt angle between the main reflector coordinate system
C	    Zmr axis and the feed coordinate system Zf-axis
C
C  Outputs:
C
C  FOCAL  Main reflector focal length
C  OFFH   Offset of the center of the main reflector
C  THETU  Offset angle of the top of the main reflector
C  THETL  Offset angle of the bottom of the main reflector
C  EC	    Subreflector eccentricity
C  AH	    Subreflector radial parameter
C  SUBF   Subreflector half interfocal distance
C  CRM	Point expressed in the main reflector coordinate system
C	    defining the center of the approximated elliptical aperture
C  DSX	Major axis of the subreflector approximated elliptical
C	    aperture parallel to the X-sr axis
C  DSY	Minor axis of the subreflector approximated elliptical
C	    aperture parallel to the Y-sr axis
C  BETA   Tilt angle between the subreflector coordinate system Zsr axis
C	    and the main reflector coordinate system Zmr axis
C  FEA    Feed half subtended angle between Zf axis and the edge of
C	    the subreflector
C  DFMR   Minimum vertical distance between the feed (Fo) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C  DSRMR  Minimum vertical distance between SR edges (P1,P2) and the main
C	    reflector edges (Q1 (upper point) and Q2 (lower point))
C
C  All angles radians
C
      DIMENSION P1(3),P2(3),FO(3),CSR(3),CRM(3),CMR(3),XX(5)
      EXTERNAL SUMDIA
      PI=2.*ACOS(0.)
C  -------- Equation 3
      TBETA=2.*SIN(FTILT/2.)**2*COS(OFFSA/2.)/(SIN(FTILT)*COS(OFFSA/2.)
     1 -SIN(OFFSA/2.))
      BETA=FTILT/2.+ATAN(SIN(FTILT/2.)*SIN(OFFSA/2.)/(SIN((FTILT-OFFSA)
     1/2.)+SIN(FTILT/2.)*COS(OFFSA/2.)))
C  -------- Equation 4
      ALPHA=FTILT-BETA
C  -------- Equation 5
      EC=SIN((BETA+ALPHA)/2.)/SIN((BETA-ALPHA)/2.)
C  -------- Equation 12
      OFFH=2.*FOCAL*TAN(-OFFSA/2.)
C  -------- Equation 18
      FOCAL=OFFH/2./TAN(-OFFSA/2.)
C  -------- Equation 19
      TFEAH=DISTM*SIN(BETA)/(4.*FOCAL*SIN(FTILT-BETA))
C  -------- Equation 14
      AH=OFFH/(2.*SIN(ABS(OFFSA)))-(DISTM+DISTS)/2.
C  -------- Equation 15
      SUBF=AH*EC
C  -------- Equation 20
      THETU=-2.*ATAN((OFFH+DISTM/2.)/(2.*FOCAL))
C  -------- Equation 21
      THETL=-2.*ATAN((OFFH-DISTM/2.)/(2.*FOCAL))
C  -------- Equation 8
      PAR=2.*FOCAL*TAN(OFFSA/2.)-2.*SUBF*SIN(BETA)
      DFMR=ABS(PAR)-DISTM/2.
C  -------- Equation 9
      AA=ABS(ALPHA)
      PF1=2.*SUBF*SIN(AA-FEA)/SIN(PI-ABS(AA-FEA)-ABS(ABS(BETA)
     1 -ABS(THETU)))
      PF2=2.*SUBF*SIN(AA+FEA)/SIN(PI-ABS(AA+FEA)-ABS(ABS(BETA)
     1 -ABS(THETL)))
      P1(1)=-PF1*SIN(THETU)
      P1(2)=0.
      P1(3)=-PF1*COS(THETU)
      P2(1)=-PF2*SIN(THETL)
      P2(2)=0.
      P2(3)=-PF2*COS(THETL)
      DSR1=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA+FEA)+1.)*SIN(FTILT+FEA)-DISTM/2.
      DSR2=-2.*FOCAL*TAN(OFFSA/2.)+2.*SUBF*SIN(BETA)-SUBF*(EC-1./EC)/
     1(EC*COS(ALPHA-FEA)+1.)*SIN(FTILT-FEA)-DISTM/2.
      DSRMR=AMIN1(DSR1,DSR2)
C  -------- Equation 22
      FO(1)=2.*SUBF*COS(BETA+PI/2.)
      FO(2)=0.
      FO(3)=-2.*SUBF*SIN(BETA+PI/2.)
      FOP1=SQRT((FO(1)-P1(1))**2+(FO(3)-P1(3))**2)
      FOP2=SQRT((FO(1)-P2(1))**2+(FO(3)-P2(3))**2)
      DSX=FOP1*SIN(ALPHA+FEA)-FOP2*SIN(ALPHA-FEA)
C  -------- Equation 23
      CSR(1)=(FOP1*SIN(ALPHA+FEA)+FOP2*SIN(ALPHA-FEA))/2.
      CSR(2)=0.
      CSR(3)=-AH*SQRT(1.+CSR(1)**2/(SUBF**2-AH**2))-SUBF
C  -------- Equation 24
      CRM(1)=COS(BETA)*CSR(1)+SIN(BETA)*CSR(3)
      CRM(2)=0.
      CRM(3)=-SIN(BETA)*CSR(1)+COS(BETA)*CSR(3)
      THETC=ATAN(CRM(1)/CRM(3))
      OCMR=2.*FOCAL/(1.+COS(THETC))
      CMR(1)=-OCMR*SIN(THETC)
      CMR(2)=0.
      CMR(3)=-OCMR*COS(THETC)
C  -------- DC distance of the MR aperture at a height Xcmr while the
C	    projected aperture of MR on the (0,x,y) plane is a circle DM
      DC=DM*SQRT(1.-4.*(CMR(1)-OFFH)**2/DM**2)
      XX(2)=EC
      XX(3)=AH
      XX(4)=FEA
      XX(5)=ALPHA
      AP=0.
      BP=2.*PI
      ALPH=1.E-5
      RT=1.
      CALL FIBON(XX,AP,BP,ALPH,AF,BF,FA,FB,SUMDIA,RT)
      DSY=AMAX1(FA,FB)
      RETURN
      END

