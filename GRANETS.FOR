      PROGRAM GRANETS
C
C  Designing Axially Symmetric Schwarzschild Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Code: T.A. Milligan
C
      REAL LM,LS,L,M
	TR=ACOS(0.)/90.
	OPEN(66,FILE='granets.out')
      WRITE(6,1)
    1 FORMAT(' Enter design number (0 all) ',$)
      READ(5,*)IEX
C  ---------- Design 1
      IF(IEX.EQ.1.OR.IEX.EQ.0)THEN
      DM=8.99377
	LM=0.8
	LS=1.7
      THETE=30.
      WRITE(66,2)DM,LM,LS,THETE
      WRITE(6,2)DM,LM,LS,THETE
    2 FORMAT(/,' Design 1. Schwarzschild Dual Reflector',/,
     1' Input parameters:',/,
     1' Main reflector diameter DM:               ',F8.5,/,
	2' Main vertex to secondary focus LM:        ',F8.5,/,
	3' Secondary focus to subreflector vertex LS:',F8.5,/,
	4' Subreflector Half subtended angle at feed ',F8.2)
	TE=THETE*TR
	DEPM=0.
	DS=0.
	DEPS=0.
	L=0
	F=0.
	BETA=0.
	VFL=0.
	RHOE=0.
	M=0
	CALL SCHGEO1(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
	WRITE(66,3)DEPM,DS,DEPS,L,F,BETA/TR,VFL,RHOE,M
	WRITE(6,3)DEPM,DS,DEPS,L,F,BETA/TR,VFL,RHOE,M
    3 FORMAT(' Output parameters:',/,
     1' Depth of main reflector dm:               ',F8.5,/,
	2' Subreflector diameter DS:                 ',F8.5,/,
	3' Depth of subreflector ds:                 ',F8.5,/,
	4' Main Vertex to subreflector vertex L:     ',F8.5,/,
	5' Radius of the Abbe Sine condition F:      ',F8.5,/,
	6' Half-subtended angle of main reflector:   ',F8.4,/,
	7' Virtual focal length VFL:                 ',F8.5,/,
	8' Feed to subreflector rim last ray Rho:    ',F8.5,/,
	8' Equivalent magnification (Cassegrain) m:  ',F8.5)
	ENDIF
C  ---------- Design 2
      IF(IEX.EQ.2.OR.IEX.EQ.0)THEN
      DM=8.99377
	DS=2.27703
	L=2.5
      THETE=30.
      WRITE(66,4)DM,DS,L,THETE
      WRITE(6,4)DM,DS,L,THETE
    4 FORMAT(/,' Design 2. Schwarzschild Dual Reflector',/,
     1' Input parameters:',/,
     1' Main reflector diameter DM:               ',F8.5,/,
	2' Subreflector diameter DS:                 ',F8.5,/,
	4' Main Vertex to subreflector vertex L:     ',F8.5,/,
	4' Subreflector Half subtended angle at feed ',F8.2)
	TE=THETE*TR
	DEPM=0.
	LM=0.
	LS=0.
	DEPS=0.
	F=0.
	BETA=0.
	VFL=0.
	RHOE=0.
	M=0
	CALL SCHGEO2(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
	WRITE(66,5)LM,DEPM,LS,DEPS,L,F,BETA/TR,VFL,RHOE,M
	WRITE(6,5)LM,DEPM,LS,DEPS,L,F,BETA/TR,VFL,RHOE,M
    5 FORMAT(' Output parameters:',/,
	2' Main vertex to secondary focus LM:        ',F8.5,/,
     1' Depth of main reflector dm:               ',F8.5,/,
	3' Secondary focus to subreflector vertex,LS ',F8.5,/,
	3' Depth of subreflector ds:                 ',F8.5,/,
	4' Main Vertex to subreflector vertex L:     ',F8.5,/,
	5' Radius of the Abbe Sine condition F:      ',F8.5,/,
	6' Half-subtended angle of main reflector:   ',F8.4,/,
	7' Virtual focal length VFL:                 ',F8.5,/,
	8' Feed to subreflector rim last ray Rho:    ',F8.5,/,
	8' Equivalent magnification (Cassegrain) m:  ',F8.5)
	ENDIF
C  ---------- Design 3
      IF(IEX.EQ.3.OR.IEX.EQ.0)THEN
      DM=8.99377
	DEPM=1.62565
	L=2.5
      THETE=30.
      WRITE(66,6)DM,DEPM,L,THETE
      WRITE(6,6)DM,DEPM,L,THETE
    6 FORMAT(/,' Design 3. Schwarzschild Dual Reflector',/,
     1' Input parameters:',/,
     1' Main reflector diameter DM:               ',F8.5,/,
     1' Depth of main reflector dm:               ',F8.5,/,
	4' Main Vertex to subreflector vertex L:     ',F8.5,/,
	4' Subreflector Half subtended angle at feed ',F8.2)
	TE=THETE*TR
	LM=0.
	DS=0.
	LS=0.
	DEPS=0.
	F=0.
	BETA=0.
	VFL=0.
	RHOE=0.
	M=0
	CALL SCHGEO3(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
	WRITE(66,7)LM,DS,LS,DEPS,F,BETA/TR,VFL,RHOE,M
	WRITE(6,7)LM,DS,LS,DEPS,F,BETA/TR,VFL,RHOE,M
    7 FORMAT(' Output parameters:',/,
	2' Main vertex to secondary focus LM:        ',F8.5,/,
	2' Subreflector diameter DS:                 ',F8.5,/,
	3' Secondary focus to subreflector vertex,LS ',F8.5,/,
	3' Depth of subreflector ds:                 ',F8.5,/,
	5' Radius of the Abbe Sine condition F:      ',F8.5,/,
	6' Half-subtended angle of main reflector:   ',F8.4,/,
	7' Virtual focal length VFL:                 ',F8.5,/,
	8' Feed to subreflector rim last ray Rho:    ',F8.5,/,
	8' Equivalent magnification (Cassegrain) m:  ',F8.5)
	ENDIF
C  ---------- Design 4
      IF(IEX.EQ.4.OR.IEX.EQ.0)THEN
      DM=8.99377
	DS=2.27703
      THETE=30.
	BETA=71.1536*TR
      WRITE(66,8)DM,DS,THETE,BETA/TR
      WRITE(6,8)DM,DS,THETE,BETA/TR
    8 FORMAT(/,' Design 4. Schwarzschild Dual Reflector',/,
     1' Input parameters:',/,
     1' Main reflector diameter DM:               ',F8.5,/,
	2' Subreflector diameter DS:                 ',F8.5,/,
	4' Subreflector Half subtended angle at feed ',F8.2,/,
	6' Half-subtended angle of main reflector:   ',F8.4)
	TE=THETE*TR
	LM=0.
	DEPM=0.
	LS=0.
	DEPS=0.
	L=0.
	F=0.
	VFL=0.
	RHOE=0.
	M=0
	CALL SCHGEO4(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
	WRITE(66,9)LM,DEPM,LS,DEPS,L,F,VFL,RHOE,M
	WRITE(6,9)LM,DEPM,LS,DEPS,L,F,VFL,RHOE,M
    9 FORMAT(' Output parameters:',/,
	2' Main vertex to secondary focus LM:        ',F8.5,/,
     1' Depth of main reflector dm:               ',F8.5,/,
	3' Secondary focus to subreflector vertex,LS ',F8.5,/,
	3' Depth of subreflector ds:                 ',F8.5,/,
	4' Main Vertex to subreflector vertex L:     ',F8.5,/,
	5' Radius of the Abbe Sine condition F:      ',F8.5,/,
	7' Virtual focal length VFL:                 ',F8.5,/,
	8' Feed to subreflector rim last ray Rho:    ',F8.5,/,
	8' Equivalent magnification (Cassegrain) m:  ',F8.5)
	ENDIF
	WRITE(6,10)
   10 FORMAT(/,' Ticra dimensions using Roberts equations')
      CALL SROBERTS(TE,LM,LS,F)
	WRITE(6,11)
   11 FORMAT(/,' Ticra dimensions using Clayton equations')
      CALL SCLAYDON(TE,LM,LS,F)
      END
C
      SUBROUTINE SCHGEO1(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
C
C  Symmetrical Schwarzschild Dual Reflector Geometry Set 1
C
C  Input parameters:
C
C  DM    Main reflector diameter
C  LM    Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C
C  Output parameters
C
C  DEPM  Depth of main reflector
C  DS    Subreflector diameter
C  DEPS  Depth of subreflector
C  L     LM + LS Vertex of main to vertex of subreflector
C  F     Radius of the circle of the Abbe Sine condition
C  BETA  Half-subtended angle of main reflector (radians)
C  VFL   Virtual focal length of the Schwartzshild dual-reflector system
C        Main is not parabola. This point determined by rim ray tracing.
C  RHOE  Feed to subreflector rim for last ray
C  M     Equivalent magnification (Cassegrain equivalent)
C
C
      REAL LM,LS,L,M
	SE=SIN(TE/2.)**2
C  ----------- Equation 1
      F=DM/2./SIN(TE)
C  ----------- Equation 2
      L=LM+LS
C  ----------- Equation 3
      RHOE=(L-LM)*L/((L-LM)*SE+L*(1-SE)**(-L/(F-L))*((L-SE*F)/L)
	1 **(F/(F-L)))
C  ----------- Equation 4
      DS=2.*RHOE*SIN(TE)
C  ----------- Equation 5
	DEPM=(1-SE)*(F**2*SE+RHOE*(L-2*F*SE))/(L-RHOE*SE)-LS
C  ----------- Equation 6
	DEPS=RHOE*COS(TE)-LS
C  ----------- Equation 7
	TBETA=0.5*(DM-DS)/(L+RHOE*COS(TE)-(1.-SE)*(F**2*SE
	1 +RHOE*(L-2*F*SE))/(L-RHOE*SE))
	BETA=ATAN(TBETA)
C  ----------- Equation 8
	VFL=DEPM+DM/2./TBETA
	M=LS/(VFL-L)
	RETURN
      END
C
      SUBROUTINE SCHGEO2(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
C
C  Symmetrical Schwarzschild Dual Reflector Geometry Set 2
C
C  Input parameters:
C
C  DM    Main reflector diameter
C  DS    Subreflector diameter
C  TE    Subreflector Half subtended angle at feed (radians)
C  L     LM + LS Vertex of main to vertex of subreflector
C
C  Output parameters
C
C  LM    Vertex to secondary focus
C  DEPM  Depth of main reflector
C  LS    Secondary focus to subreflector vertex
C  DEPS  Depth of subreflector
C  F     Radius of the circle of the Abbe Sine condition
C  BETA  Half-subtended angle of main reflector (radians)
C  VFL   Virtual focal length of the Schwartzshild dual-reflector system
C        Main is not parabola. This point determined by rim ray tracing.
C  RHOE  Feed to subreflector rim for last ray
C  M     Equivalent magnification (Cassegrain equivalent)
C
C
      REAL LM,LS,L,M
	SE=SIN(TE/2.)**2
C  ----------- Equation 1
      F=DM/2./SIN(TE)
C  ----------- Equation 11
	RHOE=F*DS/DM
C  ----------- Equation 9
	LS=RHOE*L*(1.-SE)**(-L/(F-L))*((L-SE*F)/L)**(F/(F-L))/(L-RHOE*SE)
C  ----------- Equation 10
	LM=L-LS
C  ----------- Equation 5
	DEPM=(1-SE)*(F**2*SE+RHOE*(L-2*F*SE))/(L-RHOE*SE)-LS
C  ----------- Equation 6
	DEPS=RHOE*COS(TE)-LS
C  ----------- Equation 7
	TBETA=0.5*(DM-DS)/(L+RHOE*COS(TE)-(1.-SE)*(F**2*SE
	1 +RHOE*(L-2*F*SE))/(L-RHOE*SE))
	BETA=ATAN(TBETA)
C  ----------- Equation 8
	VFL=DEPM+DM/2./TBETA
	M=LS/(VFL-L)
	RETURN
      END
C
      SUBROUTINE SCHGEO3(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
C
C  Symmetrical Schwarzschild Dual Reflector Geometry Set 3
C
C  Input parameters:
C
C  DM    Main reflector diameter
C  DEPM  Depth of main reflector
C  TE    Subreflector Half subtended angle at feed (radians)
C  L     LM + LS Vertex of main to vertex of subreflector
C
C  Output parameters
C
C  LM    Vertex to secondary focus
C  DS    Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  DEPS  Depth of subreflector
C  F     Radius of the circle of the Abbe Sine condition
C  BETA  Half-subtended angle of main reflector (radians)
C  VFL   Virtual focal length of the Schwartzshild dual-reflector system
C        Main is not parabola. This point determined by rim ray tracing.
C  RHOE  Feed to subreflector rim for last ray
C  M     Equivalent magnification (Cassegrain equivalent)
C
C
      REAL LM,LS,L,M
	SE=SIN(TE/2.)**2
C  ----------- Equation 1
      F=DM/2./SIN(TE)
C  ----------- Equation 12
	RHOE=(DEPM*L-(1.-SE)*F**2*SE)/((L-2.*F*SE)*(1.-SE)
	1 -L*(1.-SE)**(-L/(F-L))*((L-SE*F)/L)**(F/(F-L))+DEPM*SE)
C  ----------- Equation 4
      DS=2.*RHOE*SIN(TE)
C  ----------- Equation 9
	LS=RHOE*L*(1.-SE)**(-L/(F-L))*((L-SE*F)/L)**(F/(F-L))/(L-RHOE*SE)
C  ----------- Equation 10
	LM=L-LS
C  ----------- Equation 6
	DEPS=RHOE*COS(TE)-LS
C  ----------- Equation 7
	TBETA=0.5*(DM-DS)/(L+RHOE*COS(TE)-(1.-SE)*(F**2*SE
	1 +RHOE*(L-2*F*SE))/(L-RHOE*SE))
	BETA=ATAN(TBETA)
C  ----------- Equation 8
	VFL=DEPM+DM/2./TBETA
	M=LS/(VFL-L)
	RETURN
      END
C
      SUBROUTINE SCHGEO4(DM,LM,DEPM,DS,LS,DEPS,TE,L,F,BETA,VFL,RHOE,M)
C
C  Symmetrical Schwarzschild Dual Reflector Geometry Set 4
C
C  Input parameters:
C
C  DM    Main reflector diameter
C  DS    Subreflector diameter
C  TE    Subreflector Half subtended angle at feed (radians)
C  BETA  Half-subtended angle of main reflector (radians)
C
C  Output parameters
C
C  LM    Vertex to secondary focus
C  DEPM  Depth of main reflector
C  LS    Secondary focus to subreflector vertex
C  DEPS  Depth of subreflector
C  F     Radius of the circle of the Abbe Sine condition
C  VFL   Virtual focal length of the Schwartzshild dual-reflector system
C        Main is not parabola. This point determined by rim ray tracing.
C  RHOE  Feed to subreflector rim for last ray
C  M     Equivalent magnification (Cassegrain equivalent)
C
C
      REAL LM,LS,L,M
	DIMENSION A(3)
	COMPLEX ROOTS(2)
	SE=SIN(TE/2.)**2
	TBETA=TAN(BETA)
C  ----------- Equation 1
      F=DM/2./SIN(TE)
C  ----------- Equation 11
	RHOE=F*DS/DM
C  ----------- Equation 13
	A(1)=(1.-SE)*F*SE*(F-2.*RHOE)+RHOE*SE*(RHOE+(DM-DS)/2./SIN(BETA))
	A(2)=-2.*RHOE*SE-(DM-DS)/2./SIN(BETA)
	A(3)=1.
	CALL QUADR(A,ROOTS,ICOMP)
	IF(ICOMP.EQ.1)RETURN
	L=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 9
	LS=RHOE*L*(1.-SE)**(-L/(F-L))*((L-SE*F)/L)**(F/(F-L))/(L-RHOE*SE)
C  ----------- Equation 10
	LM=L-LS
C  ----------- Equation 5
	DEPM=(1-SE)*(F**2*SE+RHOE*(L-2*F*SE))/(L-RHOE*SE)-LS
C  ----------- Equation 6
	DEPS=RHOE*COS(TE)-LS
C  ----------- Equation 8
	VFL=DEPM+DM/2./TBETA
	M=LS/(VFL-L)
	RETURN
      END
C
      SUBROUTINE QUADR(A,ROOTS,ICOMP)
C 
C  Roots of quadratic equation
C 
C  A(3)   Coefficients of polynomial
C         A(1)+X*A(2)+X**2*A(3) 
C  ROOTS(2)  Roots of equation
C  ICOMP  = 1 if complex roots, 0 otherwise 
C 
      DIMENSION A(3)
      COMPLEX ROOTS(2),Q,RADCC
      RADC=A(2)*A(2)-4.*A(1)*A(3) 
      RADCC=CMPLX(RADC,0.)  
      ICOMP=0 
      IF(RADC.LT.0.)ICOMP=1 
      Q=-(A(2)+SIGN(1.,A(2))*CSQRT(RADCC))/2. 
      ROOTS(1)=Q/A(3) 
      ROOTS(2)=A(1)/Q 
      RETURN
      END
C
      SUBROUTINE SROBERTS(TE,LM,LS,F)
C
C  Roberts' equations for Schwarzschild Dual Reflector
C
C  Output in Ticra rotationally symmetric surface file format
C
C  TE    Subreflector Half subtended angle at feed (radians)
C  LM    Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  F     Radius of the circle of the Abbe Sine condition
C
      CHARACTER FIMAIN*72,FISUB*72,LABEL*72
	REAL LM,LS,L
	WRITE(6,1)
    1 FORMAT(' Enter file name for main reflector ')
      READ(5,2)FIMAIN
    2 FORMAT(A72)
	OPEN(30,FILE=FIMAIN)
	WRITE(6,3)
    3 FORMAT(' Enter file label')
      READ(5,2)LABEL
	WRITE(30,2)LABEL
	WRITE(6,4)
    4 FORMAT(' Enter file name for subreflector ')
      READ(5,2)FISUB
	OPEN(31,FILE=FISUB)
	WRITE(6,3)
      READ(5,2)LABEL
	WRITE(31,2)LABEL
	WRITE(6,5)
    5 FORMAT(' Enter number of points along radius ',$)
      READ(5,*)NP
	KSPACE=1
	KTIP=0
	WRITE(30,6)NP,KSPACE,KTIP
	WRITE(31,6)NP,KSPACE,KTIP
    6 FORMAT(3I4)
      L=LS+LM
	DTE=TE/(NP-1)
	DO 7 I=1,NP
	TH=FLOAT(I-1)*DTE
C  -------------- Equation 2
	T=TAN(TH/2.)
C  -------------- Equation 3
	ZP=LM+L*(1.-T*T)/(T*T+L/LS*(1.+T**2*(L-F)/L)**(F/(F-L)))
C  -------------- Equation 4
	XP=2.*L*T/(T*T+L/LS*(1.+T**2*(L-F)/L)**(F/(F-L)))
C  -------------- Equation 5
	ZQ=(LS*(1.+(L-F)*T*T/L)**((2.*L-F)/(L-F))+F**2*T**2/L)/(1.+T*T)**2
	1 -LS
C  -------------- Equation 6
	XQ=2.*F*T/(1.+T*T)
      WRITE(30,8)XQ,ZQ
	WRITE(31,8)XP,ZP
    7 CONTINUE
    8 FORMAT(2E18.10)
      CLOSE(30)
	CLOSE(31)
      RETURN
	END

      SUBROUTINE SCLAYDON(TE,LM,LS,F)
C
C  Claydon's equations for Schwarzschild Dual Reflector
C
C  Output in Ticra rotationally symmetric surface file format
C
C  TE    Subreflector Half subtended angle at feed (radians)
C  LM    Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  F     Radius of the circle of the Abbe Sine condition
C
      CHARACTER FIMAIN*72,FISUB*72,LABEL*72
	REAL LM,LS,L
	WRITE(6,1)
    1 FORMAT(' Enter file name for main reflector ')
      READ(5,2)FIMAIN
    2 FORMAT(A72)
	OPEN(30,FILE=FIMAIN)
	WRITE(6,3)
    3 FORMAT(' Enter file label')
      READ(5,2)LABEL
	WRITE(30,2)LABEL
	WRITE(6,4)
    4 FORMAT(' Enter file name for subreflector ')
      READ(5,2)FISUB
	OPEN(31,FILE=FISUB)
	WRITE(6,3)
      READ(5,2)LABEL
	WRITE(31,2)LABEL
	WRITE(6,5)
    5 FORMAT(' Enter number of points along radius ',$)
      READ(5,*)NP
	KSPACE=1
	KTIP=0
	WRITE(30,6)NP,KSPACE,KTIP
	WRITE(31,6)NP,KSPACE,KTIP
    6 FORMAT(3I4)
      L=LS+LM
	DTE=TE/(NP-1)
	DO 7 I=1,NP
	TH=FLOAT(I-1)*DTE
C  -------------- Equation 9
	S=SIN(TH/2.)**2
C  -------------- Equation 10
      PINV=S/L+(1.-S)**(-L/(F-L))*(1.-S*F/L)**(F/(F-L))/LS
C  -------------- Equation 11
	ZP=LM+COS(TH)/PINV
C  -------------- Equation 12
	XP=SIN(TH)/PINV
	PH=1./PINV
C  -------------- Equation 13
	ZQ=(1.-S)*(F**2*S+PH*(L-2.*F*S))/(L-PH*S)-LS
C  -------------- Equation 14
	XQ=2.*F*SQRT(S*(1.-S))
      WRITE(30,8)XQ,ZQ
	WRITE(31,8)XP,ZP
    7 CONTINUE
    8 FORMAT(2E18.10)
      CLOSE(30)
	CLOSE(31)
      RETURN
	END
