      PROGRAM GRANET
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Code: T.A. Milligan
C
      REAL LMCN,LSCN,LMGN,LSGN,LMCB,LSCB,LMGB,LSGB,LM,LS,LMCP,LSCP
C  -------- Cassegrain w/ no condition on blockage example
      DATA DMCN/22./,FMCN/7.379/,LMCN/1.4542/,DSCN/2.75/,LSCN/5.0868/,
     1 TECN/14./
C  -------- Gregorian w/ no condition on blockage example
      DATA DMGN/10./,FMGN/3.0928/,LMGN/1.0/,DSGN/1.1898/,LSGN/2.5/,
     1 TEGN/15./
C  -------- Cassegrain w/ condition on blockage example
      DATA DMCB/10./,FMCB/5.0/,LMCB/1.0/,DSCB/1.25/,LSCB/3.4024/,
     1 TECB/10.0369/,DFC/1./
C  -------- Gregorian w/ condition on blockage example
      DATA DMGB/10./,FMGB/5.0/,LMGB/1.0/,DSGB/1.25/,LSGB/4.64675/,
     1 TEGB/7.96175/,DFC/1./
C  -------- Cassegrain w/ condition on blockage PC: 0.8 example
      DATA DMCP/10./,FMCP/5.0/,LMCP/1.0/,DSCP/1.5625/,LSCP/3.2628/,
     1 TECP/12.8892/,DFC/1./
      TR=.01745329
      TEGB=TEGB*TR
      TECB=TECB*TR
      TEGN=TEGN*TR
      TECN=TECN*TR
      TECP=TECP*TR
      OPEN(66,FILE='granet.out')
C  -------- Cassegrain w/o minimum blockage condition
      WRITE(66,2)
      WRITE(6,2)
    2 FORMAT(/,' Test cases for Cassegrain w/o blockage condition',//,
     1'      Main   Main   Vertex   Subref   Feed    Conic   Subref',/,
     2' No   Dia.   Focal  t feed    Dia.    t Sub.    a     Focal')
    3 FORMAT(I3,F7.3,F8.4,F8.4,F9.4,F8.4,F8.4,F8.4)
      SIGMA=-1.
      ICASE=1
      CALL DRGEON1(SIGMA,DMCN,LMCN,LSCN,TECN,FM,DS,A,FS)
      WRITE(66,3)ICASE,DMCN,FM,LMCN,DS,LSCN,A,FS
      WRITE(6,3)ICASE,DMCN,FM,LMCN,DS,LSCN,A,FS
      ICASE=2
      CALL DRGEON2(SIGMA,DMCN,FMCN,LMCN,TECN,DS,LS,A,FS)
      WRITE(66,3)ICASE,DMCN,FMCN,LMCN,DS,LS,A,FS
      WRITE(6,3)ICASE,DMCN,FMCN,LMCN,DS,LS,A,FS
      ICASE=3
      CALL DRGEON3(SIGMA,DMCN,FMCN,LSCN,TECN,LM,DS,A,FS)
      WRITE(66,3)ICASE,DMCN,FMCN,LM,DS,LSCN,A,FS
      WRITE(6,3)ICASE,DMCN,FMCN,LM,DS,LSCN,A,FS
      ICASE=4
      CALL DRGEON4(SIGMA,FMCN,DSCN,LSCN,TECN,DM,LM,A,FS)
      WRITE(66,3)ICASE,DM,FMCN,LM,DSCN,LSCN,A,FS
      WRITE(6,3)ICASE,DM,FMCN,LM,DSCN,LSCN,A,FS
      ICASE=5
      CALL DRGEON5(SIGMA,LMCN,DSCN,LSCN,TECN,DM,FM,A,FS)
      WRITE(66,3)ICASE,DM,FM,LMCN,DSCN,LSCN,A,FS
      WRITE(6,3)ICASE,DM,FM,LMCN,DSCN,LSCN,A,FS
      ICASE=6
      CALL DRGEON6(SIGMA,DMCN,FMCN,DSCN,TECN,LM,LS,A,FS)
      WRITE(66,3)ICASE,DMCN,FMCN,LM,DSCN,LS,A,FS
      WRITE(6,3)ICASE,DMCN,FMCN,LM,DSCN,LS,A,FS
      ICASE=7
      CALL DRGEON7(SIGMA,DMCN,DSCN,LSCN,TECN,FM,LM,A,FS)
      WRITE(66,3)ICASE,DMCN,FM,LM,DSCN,LSCN,A,FS
      WRITE(6,3)ICASE,DMCN,FM,LM,DSCN,LSCN,A,FS
C  -------- Gregorian w/o minimum blockage condition
      WRITE(66,4)
      WRITE(6,4)
    4 FORMAT(/,' Test cases for Gregorian w/o blockage condition',//,
     1'      Main   Main   Vertex   Subref   Feed    Conic   Subref',/,
     2' No   Dia.   Focal  t feed    Dia.    t Sub.    a     Focal')
      SIGMA=1.
      ICASE=1
      CALL DRGEON1(SIGMA,DMGN,LMGN,LSGN,TEGN,FM,DS,A,FS)
      WRITE(66,3)ICASE,DMGN,FM,LMGN,DS,LSGN,A,FS
      WRITE(6,3)ICASE,DMGN,FM,LMGN,DS,LSGN,A,FS
      ICASE=2
      CALL DRGEON2(SIGMA,DMGN,FMGN,LMGN,TEGN,DS,LS,A,FS)
      WRITE(66,3)ICASE,DMGN,FMGN,LMGN,DS,LS,A,FS
      WRITE(6,3)ICASE,DMGN,FMGN,LMGN,DS,LS,A,FS
      ICASE=3
      CALL DRGEON3(SIGMA,DMGN,FMGN,LSGN,TEGN,LM,DS,A,FS)
      WRITE(66,3)ICASE,DMGN,FMGN,LM,DS,LSGN,A,FS
      WRITE(6,3)ICASE,DMGN,FMGN,LM,DS,LSGN,A,FS
      ICASE=4
      CALL DRGEON4(SIGMA,FMGN,DSGN,LSGN,TEGN,DM,LM,A,FS)
      WRITE(66,3)ICASE,DM,FMGN,LM,DSGN,LSGN,A,FS
      WRITE(6,3)ICASE,DM,FMGN,LM,DSGN,LSGN,A,FS
      ICASE=5
      CALL DRGEON5(SIGMA,LMGN,DSGN,LSGN,TEGN,DM,FM,A,FS)
      WRITE(66,3)ICASE,DM,FM,LMGN,DSGN,LSGN,A,FS
      WRITE(6,3)ICASE,DM,FM,LMGN,DSGN,LSGN,A,FS
      ICASE=6
      CALL DRGEON6(SIGMA,DMGN,FMGN,DSGN,TEGN,LM,LS,A,FS)
      WRITE(66,3)ICASE,DMGN,FMGN,LM,DSGN,LS,A,FS
      WRITE(6,3)ICASE,DMGN,FMGN,LM,DSGN,LS,A,FS
      ICASE=7
      CALL DRGEON7(SIGMA,DMGN,DSGN,LSGN,TEGN,FM,LM,A,FS)
      WRITE(66,3)ICASE,DMGN,FM,LM,DSGN,LSGN,A,FS
      WRITE(6,3)ICASE,DMGN,FM,LM,DSGN,LSGN,A,FS
C  -------- Cassegrain w/ minimum blockage condition
      WRITE(66,5)
      WRITE(6,5)
    5 FORMAT(/,' Test cases for Cassegrain w/ blockage condition',//,
     1'      Main   Vertex   Subref   Feed    Conic   Subref   Feed',/,
     2' No   Focal  t feed    Dia.    t Sub.    a     Focal    Subt')
    6 FORMAT(I3,F8.4,F8.4,F8.4,F9.4,F8.4,F8.4,F8.3)
      SIGMA=-1.
      ICASE=1
      CALL DRGEOB1(SIGMA,DMCB,FMCB,LMCB,DFC,DS,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FMCB,LMCB,DS,LS,A,FS,TE
      WRITE(6,6)ICASE,FMCB,LMCB,DS,LS,A,FS,TE
      ICASE=2
      CALL DRGEOB2(SIGMA,DMCB,FMCB,TECB,DFC,LM,DS,LS,A,FS)
      WRITE(66,6)ICASE,FMCB,LM,DS,LS,A,FS,TECB/TR
      WRITE(6,6)ICASE,FMCB,LM,DS,LS,A,FS,TECB/TR
      ICASE=3
      CALL DRGEOB3(SIGMA,DMCB,FMCB,DSCB,DFC,LM,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FMCB,LM,DSCB,LS,A,FS,TE
      WRITE(6,6)ICASE,FMCB,LM,DSCB,LS,A,FS,TE
      ICASE=4
      CALL DRGEOB4(SIGMA,DMCB,LMCB,DSCB,DFC,FM,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FM,LMCB,DSCB,LS,A,FS,TE
      WRITE(6,6)ICASE,FM,LMCB,DSCB,LS,A,FS,TE
      ICASE=5
      CALL DRGEOB5(SIGMA,DMCB,DSCB,TECB,DFC,FM,LM,LS,A,FS)
      WRITE(66,6)ICASE,FM,LM,DSCB,LS,A,FS,TECB/TR
      WRITE(6,6)ICASE,FM,LM,DSCB,LS,A,FS,TECB/TR
      ICASE=6
      CALL DRGEOB6(SIGMA,DMCB,LMCB,TECB,DFC,FM,DS,LS,A,FS)
      WRITE(66,6)ICASE,FM,LMCB,DS,LS,A,FS,TECB/TR
      WRITE(6,6)ICASE,FM,LMCB,DS,LS,A,FS,TECB/TR
      ICASE=7
      CALL DRGEOB7(SIGMA,DMCB,LSCB,TECB,DFC,FM,LM,DS,A,FS)
      WRITE(66,6)ICASE,FM,LM,DS,LSCB,A,FS,TECB/TR
      WRITE(6,6)ICASE,FM,LM,DS,LSCB,A,FS,TECB/TR
C  -------- Gregorian w/ minimum blockage condition
      WRITE(66,7)
      WRITE(6,7)
    7 FORMAT(/,' Test cases for Gregorian w/ blockage condition',//,
     1'      Main   Vertex   Subref   Feed    Conic   Subref   Feed',/,
     2' No   Focal  t feed    Dia.    t Sub.    a     Focal    Subt')
      SIGMA=1.
      ICASE=1
      CALL DRGEOB1(SIGMA,DMGB,FMGB,LMGB,DFC,DS,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FMGB,LMGB,DS,LS,A,FS,TE
      WRITE(6,6)ICASE,FMGB,LMGB,DS,LS,A,FS,TE
      ICASE=2
      CALL DRGEOB2(SIGMA,DMGB,FMGB,TEGB,DFC,LM,DS,LS,A,FS)
      WRITE(66,6)ICASE,FMGB,LM,DS,LS,A,FS,TEGB/TR
      WRITE(6,6)ICASE,FMGB,LM,DS,LS,A,FS,TEGB/TR
      ICASE=3
      CALL DRGEOB3(SIGMA,DMGB,FMGB,DSGB,DFC,LM,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FMGB,LM,DSGB,LS,A,FS,TE
      WRITE(6,6)ICASE,FMGB,LM,DSGB,LS,A,FS,TE
      ICASE=4
      CALL DRGEOB4(SIGMA,DMGB,LMGB,DSGB,DFC,FM,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FM,LMGB,DSGB,LS,A,FS,TE
      WRITE(6,6)ICASE,FM,LMGB,DSGB,LS,A,FS,TE
      ICASE=5
      CALL DRGEOB5(SIGMA,DMGB,DSGB,TEGB,DFC,FM,LM,LS,A,FS)
      WRITE(66,6)ICASE,FM,LM,DSGB,LS,A,FS,TEGB/TR
      WRITE(6,6)ICASE,FM,LM,DSGB,LS,A,FS,TEGB/TR
      ICASE=6
      CALL DRGEOB6(SIGMA,DMGB,LMGB,TEGB,DFC,FM,DS,LS,A,FS)
      WRITE(66,6)ICASE,FM,LMGB,DS,LS,A,FS,TEGB/TR
      WRITE(6,6)ICASE,FM,LMGB,DS,LS,A,FS,TEGB/TR
      ICASE=7
      CALL DRGEOB7(SIGMA,DMGB,LSGB,TEGB,DFC,FM,LM,DS,A,FS)
      WRITE(66,6)ICASE,FM,LM,DS,LSGB,A,FS,TEGB/TR
      WRITE(6,6)ICASE,FM,LM,DS,LSGB,A,FS,TEGB/TR
C  -------- Cassegrain w/ minimum blockage condition PC: 0.8
      WRITE(66,8)
      WRITE(6,8)
    8 FORMAT(/,' Test cases for Cassegrain w/ blockage condition',//,
     1'      Main   Vertex   Subref   Feed    Conic   Subref   Feed',/,
     2' No   Focal  t feed    Dia.    t Sub.    a     Focal    Subt')
      SIGMA=-1.
      ICASE=1
      DPC=0.8
      CALL DRGEOP1(SIGMA,DPC,DMCP,FMCP,LMCP,DFC,DS,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FMCP,LMCP,DS,LS,A,FS,TE
      WRITE(6,6)ICASE,FMCP,LMCP,DS,LS,A,FS,TE
      ICASE=2
      CALL DRGEOP2(SIGMA,DPC,DMCP,FMCP,TECP,DFC,LM,DS,LS,A,FS)
      WRITE(66,6)ICASE,FMCP,LM,DS,LS,A,FS,TECP/TR
      WRITE(6,6)ICASE,FMCP,LM,DS,LS,A,FS,TECP/TR
      ICASE=3
      CALL DRGEOP3(SIGMA,DPC,DMCP,FMCP,DSCP,DFC,LM,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FMCP,LM,DSCP,LS,A,FS,TE
      WRITE(6,6)ICASE,FMCP,LM,DSCP,LS,A,FS,TE
      ICASE=4
      CALL DRGEOP4(SIGMA,DPC,DMCP,LMCP,DSCP,DFC,FM,LS,A,FS,TE)
      TE=TE/TR
      WRITE(66,6)ICASE,FM,LMCP,DSCP,LS,A,FS,TE
      WRITE(6,6)ICASE,FM,LMCP,DSCP,LS,A,FS,TE
      ICASE=5
      CALL DRGEOP5(SIGMA,DPC,DMCP,DSCP,TECP,DFC,FM,LM,LS,A,FS)
      WRITE(66,6)ICASE,FM,LM,DSCP,LS,A,FS,TECP/TR
      WRITE(6,6)ICASE,FM,LM,DSCP,LS,A,FS,TECP/TR
      ICASE=6
      CALL DRGEOP6(SIGMA,DPC,DMCP,LMCP,TECP,DFC,FM,DS,LS,A,FS)
      WRITE(66,6)ICASE,FM,LMCP,DS,LS,A,FS,TECP/TR
      WRITE(6,6)ICASE,FM,LMCP,DS,LS,A,FS,TECP/TR
      ICASE=7
      CALL DRGEOP7(SIGMA,DPC,DMCP,LSCP,TECP,DFC,FM,LM,DS,A,FS)
      WRITE(66,6)ICASE,FM,LM,DS,LSCP,A,FS,TECP/TR
      WRITE(6,6)ICASE,FM,LM,DS,LSCP,A,FS,TECP/TR
      END
C
      SUBROUTINE DRGEON1(SIGMA,DM,LM,LS,TE,FM,DS,A,FS)
C
C  Symmetrical Dual Reflector Geometry w/o Blockage Condition
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  LM    Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C
C  Outputs:
C
C  FM    Main reflector focal length
C  DS    Subreflector diameter
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
C  ----------- Equation 4
      FS=LS*(SIGMA*DM-4.*LM*TAN(TE/2.))/(2.*SIGMA*DM+8.*LS*TAN(TE/2.))
C  ----------- Equation 5
      FM=LM+2.*FS
C  ----------- Equation 6
      A=LS-FS
C  ----------- Equation 7
      DS=4.*(LS-FS)/(1./SIN(TE)+SIGMA*(16.*FM**2+DM**2)/(8.*FM*DM))
      RETURN
      END
C
      SUBROUTINE DRGEON2(SIGMA,DM,FM,LM,TE,DS,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry w/o Blockage Condition
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  LM    Vertex to secondary focus
C  TE    Subreflector Half subtended angle at feed (radians)
C
C  Outputs:
C
C  DS    Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
C  ----------- Equation 8
      A=-0.5*(LM-FM)*(SIGMA*DM+4.*FM*TAN(TE/2.))/(SIGMA*DM-4.*FM
     1 *TAN(TE/2.))
C  ----------- Equation 9
      LS=-SIGMA*DM*(LM-FM)/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 10
      FS=(FM-LM)/2.
C  ----------- Equation 11
      X1=-16.*SIN(TE)*DM*FM*(LM-FM)*(SIGMA*DM+4.*FM*TAN(TE/2.))
      X2=8.*FM*DM*(SIGMA*DM-4.*FM*TAN(TE/2.))
      X3=(DM**2+16.*FM**2)*SIN(TE)*(DM-4.*SIGMA*FM*TAN(TE/2.))
      DS=X1/(X2+X3)
      RETURN
      END
C
      SUBROUTINE DRGEON3(SIGMA,DM,FM,LS,TE,LM,DS,A,FS)
C
C  Symmetrical Dual Reflector Geometry w/o Blockage Condition
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C
C  Outputs:
C
C  LM    Vertex to secondary focus
C  DS    Subreflector diameter
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
C  ----------- Equation 12
      LM=-(SIGMA*DM*(LS-FM)-4.*LS*FM*TAN(TE/2.))/(SIGMA*DM)
C  ----------- Equation 13
      DS=16.*SIN(TE)*FM*LS*(SIGMA*DM+4.*FM*TAN(TE/2.))/(8.*SIGMA*FM
     1 *DM+SIN(TE)*(DM**2+16.*FM**2))
C  ----------- Equation 14
      A=LS*(SIGMA*DM+4.*FM*TAN(TE/2.))/(2.*SIGMA*DM)
C  ----------- Equation 15
      FS=LS*(SIGMA*DM-4.*FM*TAN(TE/2.))/(2.*SIGMA*DM)
      RETURN
      END
C
      SUBROUTINE DRGEON4(SIGMA,FM,DS,LS,TE,DM,LM,A,FS)
C
C  Symmetrical Dual Reflector Geometry w/o Blockage Condition
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  FM    Main reflector focal length
C  DS    Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C
C  Outputs:
C
C  DM    Main reflector diameter
C  LM    Vertex to secondary focus
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 16
      Z(1)=16.*FM**2*SIN(TE)*(DS-4.*LS*TAN(TE/2.))
      Z(2)=8.*FM*SIGMA*(DS-2.*SIN(TE)*LS)
      Z(3)=DS*SIN(TE)
      DM=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      DM=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 12
      LM=-(SIGMA*DM*(LS-FM)-4.*LS*FM*TAN(TE/2.))/(SIGMA*DM)
C  ----------- Equation 14
      A=LS*(SIGMA*DM+4.*FM*TAN(TE/2.))/(2.*SIGMA*DM)
C  ----------- Equation 15
      FS=LS*(SIGMA*DM-4.*FM*TAN(TE/2.))/(2.*SIGMA*DM)
      RETURN
      END
C
      SUBROUTINE DRGEON5(SIGMA,LM,DS,LS,TE,DM,FM,A,FS)
C
C  Symmetrical Dual Reflector Geometry w/o Blockage Condition
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C
C  LM    Vertex to secondary focus
C  DS    Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C
C  Outputs:
C
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 17
      Z(1)=LS**2*(TAN(TE/2.)*SIN(TE)*(8.*LS-TAN(TE/2.)*DS)-DS*
     1 (2.*TAN(TE/2.)+SIN(TE)))
      Z(2)=4.*DS*LS*(SIN(TE)+TAN(TE/2.))-24.*LS**2*TAN(TE/2.)*SIN(TE)
      Z(3)=4.*SIN(TE)*(4.*LS*TAN(TE/2.)-DS)
      FS=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      FS=AMIN1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 5
      FM=LM+2.*FS
C  ----------- Equation 6
      A=LS-FS
C  ----------- Equation 18
      DM=4.*LS*TAN(TE/2.)*(LM+2.*FS)/(SIGMA*(LS-2.*FS))
      RETURN
      END
C
      SUBROUTINE DRGEON6(SIGMA,DM,FM,DS,TE,LM,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry w/o Blockage Condition
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  DS    Subreflector diameter
C  TE	 Subreflector Half subtended angle at feed (radians)
C
C  Outputs:
C
C  LM    Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  A	 Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      X1=TAN(TE/2.)*FM
      X2=8.*FM*DM+SIGMA*SIN(TE)*(16.*FM**2+DM**2)
C  ----------- Equation 23
      X3=8.*SIGMA*DM**2*FM*(DS-2.*SIN(TE)*FM)-32.*TAN(TE/2.)*FM**2
     1 *DM*(DS+2.*SIN(TE)*FM)-4.*DS*SIGMA*SIN(TE)*TAN(TE/2.)*FM*
     2 (16.*FM**2+DM**2)+DS*SIN(TE)*DM*(16.*FM**2+DM**2)
C  ----------- Equation 19
      LS=DS*SIGMA*X2/(16.*SIN(TE)*FM*(SIGMA*DM+4.*X1))
C  ----------- Equation 20
      A=DS*X2/(32.*SIN(TE)*DM*FM)
C  ----------- Equation 21
      FS=DS*X2*(SIGMA*DM-4.*X1)/(32.*SIN(TE)*FM*(SIGMA*DM+4.*X1)*DM)
C  ----------- Equation 22
      LM=-X3/(16.*DM*SIN(TE)*FM*(SIGMA*DM+4.*X1))
      RETURN
      END
C
      SUBROUTINE DRGEON7(SIGMA,DM,DS,LS,TE,FM,LM,A,FS)
C
C  Symmetrical Dual Reflector Geometry w/o Blockage Condition
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  DS	 Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C
C  Outputs:
C
C  FM	 Main reflector focal length
C  LM    Vertex to secondary focus
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 24
      Z(1)=-DS*DM**2*SIN(TE)
      Z(2)=8.*DM*SIGMA*(2.*SIN(TE)*LS-DS)
      Z(3)=16.*SIN(TE)*(4.*LS*TAN(TE/2.)-DS)
      FM=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
C
C  Note: Quadratic equation can be ill-conditioned and lead to unstable
C        solutions which lack precision. One solution given.
C
      FM=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
      IF(REAL(ROOTS(1))*REAL(ROOTS(2)).GT.0.)
     1 FM=AMIN1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 12
      LM=-(SIGMA*DM*(LS-FM)-4.*LS*FM*TAN(TE/2.))/(SIGMA*DM)
C  ----------- Equation 14
      A=LS*(SIGMA*DM+4.*FM*TAN(TE/2.))/(2.*SIGMA*DM)
C  ----------- Equation 15
      FS=LS*(SIGMA*DM-4.*FM*TAN(TE/2.))/(2.*SIGMA*DM)
      RETURN
      END
C
      SUBROUTINE DRGEOB1(SIGMA,DM,FM,LM,DF,DS,LS,A,FS,TE)
C
C  Symmetrical Dual Reflector Geometry Minimum Blockage
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  LM	 Vertex to secondary focus
C  DF	 Feed diameter
C
C  Outputs:
C
C  DS	 Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C  TE    Subreflector Half subtended angle at feed (radians)
C
      REAL LM,LS
C  ----------- Equation 10
      FS=(FM-LM)/2.
C  ----------- Equation 25
      DS=FM*DF/(2.*FS)
C  ----------- Equation 26
      TE=ATAN(8.*FM*DM*DS/(32.*FS*FM*DM+SIGMA*DS*(16.*FM**2-DM**2)))
C  ----------- Equation 27
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 6
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOB2(SIGMA,DM,FM,TE,DF,LM,DS,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Minimum Blockage
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  LM	 Vertex to secondary focus
C  DS	 Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
C  ----------- Equation 28
      FS=SQRT((8.*FM*DM*DF-SIGMA*DF*TAN(TE)*(16.*FM**2-DM**2))/
     1 (64.*TAN(TE)*DM))
C  ----------- Equation 27
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 25
      DS=FM*DF/(2.*FS)
C  ----------- Equation 6
      A=LS-FS
C  ----------- Equation 29
      LM=FM-2.*FS
      RETURN
      END
C
      SUBROUTINE DRGEOB3(SIGMA,DM,FM,DS,DF,LM,LS,A,FS,TE)
C
C  Symmetrical Dual Reflector Geometry Minimum Blockage
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  DS	 Subreflector diameter
C  DF	 Feed diameter
C
C  Outputs:
C
C  LM	 Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C  TE    Subreflector Half subtended angle at feed (radians)
C
      REAL LM,LS
C  ----------- Equation 30
      FS=FM*DF/(2.*DS)
C  ----------- Equation 29
      LM=FM-2.*FS
C  ----------- Equation 26
      TE=ATAN(8.*FM*DM*DS/(32.*FS*FM*DM+SIGMA*DS*(16.*FM**2-DM**2)))
C  ----------- Equation 27
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 6
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOB4(SIGMA,DM,LM,DS,DF,FM,LS,A,FS,TE)
C
C  Symmetrical Dual Reflector Geometry Minimum Blockage
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  LM	 Vertex to secondary focus
C  DS	 Subreflector diameter
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  LS	 Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C  TE    Subreflector Half subtended angle at feed (radians)
C
      REAL LM,LS
C  ----------- Equation 31
      FS=LM*DF/(2.*(DS-DF))
C  ----------- Equation 5
      FM=LM+2.*FS
C  ----------- Equation 26
      TE=ATAN(8.*FM*DM*DS/(32.*FS*FM*DM+SIGMA*DS*(16.*FM**2-DM**2)))
C  ----------- Equation 27
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 6
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOB5(SIGMA,DM,DS,TE,DF,FM,LM,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Minimum Blockage
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  DS	 Subreflector diameter
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  LM	 Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 32
      Z(1)=-SIGMA*DS**2*DM**2
      Z(2)=-8.*DM*DS**2/TAN(TE)
      Z(3)=16.*(DF*DM+SIGMA*DS**2)
      FM=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      FM=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 30
      FS=FM*DF/(2.*DS)
C  ----------- Equation 29
      LM=FM-2.*FS
C  ----------- Equation 27
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 6
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOB6(SIGMA,DM,LM,TE,DF,FM,DS,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Minimum Blockage
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  LM	 Vertex to secondary focus
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  DS	 Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 33
      Z(1)=TAN(TE)*DM*(16.*LM**2-SIGMA*DF*DM)
      Z(2)=-8.*DM*(4.*LM*TAN(TE)+DF)
      Z(3)=16.*TAN(TE)*(DM+SIGMA*DF)
      FM=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      FM=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 10
      FS=(FM-LM)/2.
C  ----------- Equation 25
      DS=FM*DF/(2.*FS)
C  ----------- Equation 27
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 6
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOB7(SIGMA,DM,LS,TE,DF,FM,LM,DS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Minimum Blockage
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DM    Main reflector diameter
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  LM	 Vertex to secondary focus
C  DS	 Subreflector diameter
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 34
      Z(1)=TAN(TE)*DM**2*(16.*LS**2-SIGMA*DF*DM)
      Z(2)=-8.*DM*(16.*LS**2*SIGMA*TAN(TE)*TAN(TE/2.)+DF*DM)
      Z(3)=16.*TAN(TE)*(16.*LS**2*(TAN(TE/2.))**2+SIGMA*DF*DM)
      FM=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      FM=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
      IF(REAL(ROOTS(1))*REAL(ROOTS(2)).GT.0.)
     1 FM=AMIN1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 35
      FS=-LS*(4.*FM*TAN(TE/2.)-SIGMA*DM)/(2.*SIGMA*DM)
C  ----------- Equation 29
      LM=FM-2.*FS
C  ----------- Equation 25
      DS=FM*DF/(2.*FS)
C  ----------- Equation 6
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOP1(SIGMA,DPC,DM,FM,LM,DF,DS,LS,A,FS,TE)
C
C  Symmetrical Dual Reflector Geometry Min. Blockage w/ Phase Center
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DPC	 Distance from Feed Aperture to Phase Center (into feed)
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  LM	 Vertex to secondary focus
C  DF	 Feed diameter
C
C  Outputs:
C
C  DS	 Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS    Subreflector focal length (feed to origin of subreflector)
C  TE    Subreflector Half subtended angle at feed (radians)
C
      REAL LM,LS
C  ----------- Equation 1
      FS=(FM-LM)/2.
C  ----------- Equation 2
      DS=FM*DF/(2.*FS-DPC)
C  ----------- Equation 3
      TE=ATAN(8.*FM*DM*DS/(32.*FS*FM*DM+SIGMA*DS*(16.*FM**2-DM**2)))
C  ----------- Equation 4
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 5
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOP2(SIGMA,DPC,DM,FM,TE,DF,LM,DS,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Min. Blockage w/ Phase Center
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DPC	 Distance from Feed Aperture to Phase Center (into feed)
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  LM	 Vertex to secondary focus
C  DS	 Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 6
      Z(1)=-16.*DF*FM**2*TAN(TE)*DM
      Z(2)=-16.*DPC*TAN(TE)*FM*DM
      Z(3)=8.*FM*DM-SIGMA*TAN(TE)*(16.*FM**2-DM**2)
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      X1=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
      FS=X1*Z(3)/(32.*FM*DM*TAN(TE))
C  ----------- Equation 4
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 2
      DS=FM*DF/(2.*FS-DPC)
C  ----------- Equation 5
      A=LS-FS
C  ----------- Equation 7
      LM=FM-2.*FS
      RETURN
      END
C
      SUBROUTINE DRGEOP3(SIGMA,DPC,DM,FM,DS,DF,LM,LS,A,FS,TE)
C
C  Symmetrical Dual Reflector Geometry Min. Blockage w/ Phase Center
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DPC	 Distance from Feed Aperture to Phase Center (into feed)
C  DM    Main reflector diameter
C  FM    Main reflector focal length
C  DS	 Subreflector diameter
C  DF	 Feed diameter
C
C  Outputs:
C
C  LM	 Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C  TE    Subreflector Half subtended angle at feed (radians)
C
      REAL LM,LS
C  ----------- Equation 8
      FS=(FM*DF/DS+DPC)/2.
C  ----------- Equation 7
      LM=FM-2.*FS
C  ----------- Equation 3
      TE=ATAN(8.*FM*DM*DS/(32.*FS*FM*DM+SIGMA*DS*(16.*FM**2-DM**2)))
C  ----------- Equation 4
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 5
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOP4(SIGMA,DPC,DM,LM,DS,DF,FM,LS,A,FS,TE)
C
C  Symmetrical Dual Reflector Geometry Min. Blockage w/ Phase Center
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DPC	 Distance from Feed Aperture to Phase Center (into feed)
C  DM    Main reflector diameter
C  LM	 Vertex to secondary focus
C  DS	 Subreflector diameter
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  LS	 Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C  TE    Subreflector Half subtended angle at feed (radians)
C
      REAL LM,LS
C  ----------- Equation 9
      FS=(DS*DPC+LM*DF)/(2.*(DS-DF))
C  ----------- Equation 10
      FM=LM+2.*FS
C  ----------- Equation 3
      TE=ATAN(8.*FM*DM*DS/(32.*FS*FM*DM+SIGMA*DS*(16.*FM**2-DM**2)))
C  ----------- Equation 4
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 5
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOP5(SIGMA,DPC,DM,DS,TE,DF,FM,LM,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Min. Blockage w/ Phase Center
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DPC	 Distance from Feed Aperture to Phase Center (into feed)
C  DM    Main reflector diameter
C  DS	 Subreflector diameter
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  LM	 Vertex to secondary focus
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 11
      Z(1)=-TAN(TE)*SIGMA*DS**2*DM**2
      Z(2)=16*TAN(TE)*DM*DS*DPC-8.*DM*DS**2
      Z(3)=16.*TAN(TE)*(DF*DM+SIGMA*DS**2)
      FM=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      FM=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 8
      FS=(FM*DF/DS+DPC)/2.
C  ----------- Equation 7
      LM=FM-2.*FS
C  ----------- Equation 4
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 5
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOP6(SIGMA,DPC,DM,LM,TE,DF,FM,DS,LS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Min. Blockage w/ Phase Center
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DPC	 Distance from Feed Aperture to Phase Center (into feed)
C  DM    Main reflector diameter
C  LM	 Vertex to secondary focus
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  DS	 Subreflector diameter
C  LS    Secondary focus to subreflector vertex
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 12
      Z(1)=SIGMA*TAN(TE)*DF*(16.*LM**2-DM**2)-8.*DM*DF*LM
      Z(2)=32.*TAN(TE)*(2.*SIGMA*DF*LM-DM*DPC)-16.*DM*DF
      Z(3)=64.*TAN(TE)*(DM+SIGMA*DF)
      FS=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      FS=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 10
      FM=LM+2.*FS
C  ----------- Equation 2
      DS=FM*DF/(2.*FS-DPC)
C  ----------- Equation 4
      LS=2.*SIGMA*DM*FS/(SIGMA*DM-4.*FM*TAN(TE/2.))
C  ----------- Equation 5
      A=LS-FS
      RETURN
      END
C
      SUBROUTINE DRGEOP7(SIGMA,DPC,DM,LS,TE,DF,FM,LM,DS,A,FS)
C
C  Symmetrical Dual Reflector Geometry Min. Blockage w/ Phase Center
C
C  Designing Axially Symmetric Cassegrain or Gregorian Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric Parameters
C  IEEE Antennas and Propagation Magazine, April & June 1998
C
C  Equations by Christophe Granet, CSIRO Australia
C
C  Input parameters:
C
C  SIGMA -1 Cassegrain, 1 Gregorian
C  DPC	 Distance from Feed Aperture to Phase Center (into feed)
C  DM    Main reflector diameter
C  LS    Secondary focus to subreflector vertex
C  TE    Subreflector Half subtended angle at feed (radians)
C  DF	 Feed diameter
C
C  Outputs:
C
C  FM    Main reflector focal length
C  LM	 Vertex to secondary focus
C  DS	 Subreflector diameter
C  A     Subreflector origin to vertex
C  FS	 Subreflector focal length (feed to origin of subreflector)
C
      REAL LM,LS
      DIMENSION Z(3)
      COMPLEX ROOTS(2)
C  ----------- Equation 13
      Z(1)=SIGMA*DF*DM*LS**2*(TAN(TE)*(1.-TAN(TE/2.)**2)-2.*TAN(TE/2.))
      Z(2)=4.*SIGMA*DM*DF*LS*(TAN(TE/2.)-TAN(TE))-32.*TAN(TE)*DPC
     1*LS**2*TAN(TE/2.)**2
      Z(3)=4.*TAN(TE)*((4.*LS*TAN(TE/2.))**2+SIGMA*DF*DM)
      FS=0.
      CALL QUADR(Z,ROOTS,ICOMP)
      IF(ICOMP.EQ.1)RETURN
      FS=AMAX1(REAL(ROOTS(1)),REAL(ROOTS(2)))
C  ----------- Equation 14
      FM=SIGMA*DM*(LS-2.*FS)/(4.*TAN(TE/2.)*LS)
C  ----------- Equation 7
      LM=FM-2.*FS
C  ----------- Equation 2
      DS=FM*DF/(2.*FS-DPC)
C  ----------- Equation 5
      A=LS-FS
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

