From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Mon, 12 Dec 2005 08:03:20 +0000
Subject: [lm-sensors] [PATCH] lm_sensors2 w83792d fix fan auto adjust
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECEC224D5@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEB7BF78@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEB7BF78@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,
> I've taken a look and the patch looks rather good. However there's
> something I am not happy with in the w83792d driver. It's not directly
> related to this patch, as the current code in lm_sensors CVS has the
> same issue. But as you are working in the same area, maybe you could
> fix it.
>=20
> The w83792d driver changes the fan clock dividers automatically. I'm
> fine with that, however it also lets the user change the divider
values
> manually. This does not make sense! At the next fan speed reading,
> chances are that the driver will change the divider value if it wasn't
> optimal anyway.
>=20
> So I would like fan_div to be read-only for the user. If you do that,
> you'll see that you can simplify the automatic fan div change code,
> because you will no more need to convert from divider to register
value
> (e.g. 8 -> 0x03). Your new "w83792d_set_fan_div" function will take a
> register value as its "divisor" parameter rather that a divider value.
>=20
> Can you please rework your patch in that direction?

I hope I get your idea :) The new patch is attached with this mail,
please check.
I don't know what kind of attachment type to choose, I have changed it
to BINHEX, is it right?
Thanks


Best regards
Yuan Mu



begin 666 w83792d_fix_fan_div.patch
M+2TM(&QM7W-E;G-O<G,R+F]R:6<O:V5R;F5L+V-H:7!S+W<X,S<Y,F0N8PDR
M,# U+3$R+3$R(#$P.C V.C$V+C P,# P,# P," K,#@P, HK*RL@;&U?<V5N
M<V]R<S(O:V5R;F5L+V-H:7!S+W<X,S<Y,F0N8PDR,# U+3$R+3$R(#$U.C(Y
M.C$Y+C P,# P,# P," K,#@P, I 0" M,S V+#8@*S,P-BPX($! ('-T871I
M8R!V;VED('<X,S<Y,F1?=3D&5M<%]A9&0H<W1R=3D6-T(&DR8U\*( D)"6EN=3D"!C
M=3D&Q?;F%M92P@:6YT("IN<F5L<U]M86<L(&QO;F<@*G)E<W5L=3D',I.PH@<W1A
M=3D&EC('9O:60@=3DS at S-SDR9%]V<FTH<W1R=3D6-T(&DR8U]C;&EE;G0@*F-L:65N
M=3D"P@:6YT(&]P97)A=3D&EO;BP*( D)"6EN=3D"!C=3D&Q?;F%M92P@:6YT("IN<F5L
M<U]M86<L(&QO;F<@*G)E<W5L=3D',I.R J+PHK<W1A=3D&EC('9O:60@=3DS at S-SDR
M9%]S971?9F%N7V1I=BAS=3D')U8W0@:3)C7V-L:65N=3D" J8VQI96YT+ HK"0D)
M"6EN=3D"!N<BP@=3D3@@;F5W9&EV*3L*('-T871I8R!V;VED('<X,S<Y,F1?9F%N
M7V1I=BAS=3D')U8W0@:3)C7V-L:65N=3D" J8VQI96YT+"!I;G0@;W!E<F%T:6]N
M+ H@"0D)(" @(&EN=3D"!C=3D&Q?;F%M92P@:6YT("IN<F5L<U]M86<L(&QO;F<@
M*G)E<W5L=3D',I.PH@<W1A=3D&EC('9O:60@=3DS at S-SDR9%]A;&%R;7,H<W1R=3D6-T
M(&DR8U]C;&EE;G0@*F-L:65N=3D"P@:6YT(&]P97)A=3D&EO;BP*0$ @+30T,RPW
M("LT-#4L-R! 0"!S=3D&%T:6, at 8W1L7W1A8FQE('<X,S<Y,F1?9&ER7W1A8FQE
M7W1E;7!L"B )("9I,F-?<WES8W1L7W)E86PL($Y53$PL("9W.#,W.3)D7W1E
M;7!?861D?2P*( DO*GM7.#,W.3)$7U-94T-43%]6240L(")V:60B+"!.54Q,
M+" P+" P-#0T+"!.54Q,+" F:3)C7W!R;V-?<F5A;"P*( D@)FDR8U]S>7-C
M=3D&Q?<F5A;"P at 3E5,3"P@)G<X,S<Y,F1?=FED?2P@*B\*+0E[5S at S-SDR1%]3
M65-#5$Q?1D%.7T1)5BP@(F9A;E]D:78B+"!.54Q,+" P+" P-C0T+"!.54Q,
M+" F:3)C7W!R;V-?<F5A;"P**PE[5S at S-SDR1%]365-#5$Q?1D%.7T1)5BP@
M(F9A;E]D:78B+"!.54Q,+" P+" P-#0T+"!.54Q,+" F:3)C7W!R;V-?<F5A
M;"P*( D@)FDR8U]S>7-C=3D&Q?<F5A;"P at 3E5,3"P@)G<X,S<Y,F1?9F%N7V1I
M=3DGTL"B )>U<X,S<Y,D1?4UE30U1,7T%,05)-4RP@(F%L87)M<R(L($Y53$PL
M(# L(# V-#0L($Y53$PL"B )("9I,F-?<')O8U]R96%L+" F:3)C7W-Y<V-T
M;%]R96%L+"!.54Q,+" F=3DS at S-SDR9%]A;&%R;7-]+ I 0" M.#,R+#8@*S at S
M-"PR,2! 0"!S=3D&%T:6,@=3DF]I9"!W.#,W.3)D7W5P9&%T95]C;&EE;G0H<W1R
M=3D6-T"B )"61A=3D&$M/F9A;E]D:79;-5T@/2 H<F5G7V%R<F%Y7W1M<%LR72 ^
M/B T*2 F(#!X,#<["B )"61A=3D&$M/F9A;E]D:79;-ET@/2!R96=3D?87)R87E?
M=3D&UP6S-=3D("8@,'@P-SL*( HK"0EF;W(@*&D@/2 P.R!I(#P at -SL@:2LK*2![
M"BL)"0EI9B H(2AD871A+3YH87-?9F%N("8@*#$@/#P@:2DI*0HK"0D)"6-O
M;G1I;G5E.PHK"0D):68@*&1A=3D&$M/F9A;EMI72 ]/2 P>&9F("8F(&1A=3D&$M
M/F9A;E]D:79;:5T@/" W*0HK"0D)"7<X,S<Y,F1?<V5T7V9A;E]D:78H8VQI
M96YT+"!I+" W*3L**PD)"65L<V4@:68@*&1A=3D&$M/F9A;EMI72 \(#!X-S @
M)B8 at 9&%T82T^9F%N7V1I=3DEMI72 ^(# I('L**PD)"0EW.#,W.3)D7W-E=3D%]F
M86Y?9&EV*&-L:65N=3D"P@:2P**PD)"0D)"0ED871A+3YF86Y?9&EV6VE=3D("T@
M,2D["BL)"0E](&5L<V4@:68@*&1A=3D&$M/F9A;EMI72 ^(#!X9C@@)B8**PD)
M"0D)"61A=3D&$M/F9A;E]D:79;:5T@/" W*2!["BL)"0D)=3DS at S-SDR9%]S971?
M9F%N7V1I=BAC;&EE;G0L(&DL"BL)"0D)"0D)9&%T82T^9F%N7V1I=3DEMI72 K
M(#$I.PHK"0D)?0HK"0E]"BL*( D)+RH at 57!D871E('1H92!496UP97)A=3D'5R
M93$@;65A<W5R960@=3DF%Ld at 86YD(&QI;6ET<R J+PH@"0ED871A+3YT96UP
M,5LP72 ]('<X,S<Y,F1?<F5A9%]V86QU92AC;&EE;G0L(%<X,S<Y,D1?4D5'
M7U1%35 Q*3L*( D)9&%T82T^=3D&5M<#%;,5T@/2!W.#,W.3)D7W)E861?=3DF%L
MdH8VQI96YT+"!7.#,W.3)$7U)%1U]414U0,5]/5D52*3L*0$ @+3$P,#$L
M,3,@*S$P,3 at L,S@@0$ @<W1A=3D&EC('9O:60@=3DS at S-SDR9%]I;BAS=3D')U8W0@
M:3)C7V-L:65N=3D H@"7T*('T*( HK<W1A=3D&EC('9O:60@=3DS at S-SDR9%]S971?
M9F%N7V1I=BAS=3D')U8W0@:3)C7V-L:65N=3D" J8VQI96YT+"!I;G0@;G(L('4X
M(&YE=3DV1I=BD**WL**PES=3D')U8W0@=3DS at S-SDR9%]D871A("ID871A(#T at 8VQI
M96YT+3YD871A.PHK"6EN=3D"!M:6X@/2 P.PHK"6EN=3D"!O;&0@/2 P.PHK"74X
M('1M<" ](# ["BL**PEN97=3DD:78@/2!314Y33U)37TQ)34E4*&YE=3DV1I=3DBP@
M,"P at -RD["BL**PEI9B H;F5W9&EV(#T](&1A=3D&$M/F9A;E]D:79;;G)=3D*2![
M"BL)"7)E=3D'5R;CL**PE]"BL**PEM:6X@/2!&04Y?1E)/35]214<H9&%T82T^
M9F%N7VUI;EMN<ETL($1)5E]&4D]-7U)%1RAD871A+3YF86Y?9&EV6VYR72DI
M.PHK"6]L9" ]($9!3E]&4D]-7U)%1RAD871A+3YF86Y;;G)=3D+"!$259?1E)/
M35]214<H9&%T82T^9F%N7V1I=3DEMN<ETI*3L**PED871A+3YF86Y?9&EV6VYR
M72 ](&YE=3DV1I=3DCL**PET;7 @/2!W.#,W.3)D7W)E861?=3DF%LdH8VQI96YT
M+"!7.#,W.3)$7U)%1U]&04Y?1$E66VYR(#X^(#%=3D*3L**PET;7 @)CT@*&YR
M("8@,2D@/R P>#AF(#H@,'AF.#L**PET;7 @?#T@*&YR("8@,2D@/R H*&YE
M=3DV1I=3DB \/" T*2 F(#!X-S I(#H@*&YE=3DV1I=3DB F(#!X,#<I.PHK"7<X,S<Y
M,F1?=3DW)I=3D&5?=3DF%LdH8VQI96YT+"!7.#,W.3)$7U)%1U]&04Y?1$E66VYR
M(#X^(#%=3D+"!T;7 I.PHK"61A=3D&$M/F9A;E]M:6Y;;G)=3D(#T at 1D%.7U1/7U)%
M1RAM:6XL($1)5E]&4D]-7U)%1RAD871A+3YF86Y?9&EV6VYR72DI.PHK"61A
M=3D&$M/F9A;EMN<ET@/2!&04Y?5$]?4D5'*&]L9"P at 1$E67T923TU?4D5'*&1A
M=3D&$M/F9A;E]D:79;;G)=3D*2D["BL)=3DS at S-SDR9%]W<FET95]V86QU92AC;&EE
M;G0L(%<X,S<Y,D1?4D5'7T9!3E]-24Y;;G)=3D+ HK"0D)"61A=3D&$M/F9A;E]M
M:6Y;;G)=3D*3L**WT**PH at +RH@<F5A9"]W<FET92!F86X@;65A=3D7)E9"!V86QU
M92!A;F0@;&EM:71S("HO"B!S=3D&%T:6,@=3DF]I9"!W.#,W.3)D7V9A;BAS=3D')U
M8W0@:3)C7V-L:65N=3D" J8VQI96YT+"!I;G0@;W!E<F%T:6]N+"!I;G0 at 8W1L
M7VYA;64L"B )"2!I;G0@*FYR96QS7VUA9RP@;&]N9R J<F5S=3D6QT<RD*('L*
M( ES=3D')U8W0@=3DS at S-SDR9%]D871A("ID871A(#T at 8VQI96YT+3YD871A.PH@
M"6EN=3D"!N<B ](&-T;%]N86UE("T at 5S@S-SDR1%]365-#5$Q?1D%.,3L*+0EU
M."!T;7!?<F5G+"!T;7!?9F%N7V1I=3DCL*( H@"2\J(')E<W5L=3D%LP73H@;&]W
M(&QI;6ET+"!R97-U;'1;,5TZ(&UE87-U<F5D('9A;'5E("HO"B ):68@*&]P
M97)A=3D&EO;B ]/2!314Y33U)37U!23T-?4D5!3%])3D9/*0I 0" M,3 Q-2PT
M-" K,3 U-RPQ,R! 0"!S=3D&%T:6,@=3DF]I9"!W.#,W.3)D7V9A;BAS=3D')U8W0@
M:3)C7V-L:65N"B )96QS92!I9B H;W!E<F%T:6]N(#T](%-%3E-/4E-?4%)/
M0U]214%,7U)%040I('L*( D)=3DS at S-SDR9%]U<&1A=3D&5?8VQI96YT*&-L:65N
M=3D"D["B )"7)E<W5L=3D'-;,%T@/2!&04Y?1E)/35]214<H9&%T82T^9F%N7VUI
M;EMN<ETL"BT)"0D)("!$259?1E)/35]214<H9&%T82T^9F%N7V1I=3DEMN<ETI
M*3L*+0D)+RH at 861J=3D7-T($9A;B!$:79I<V]R+"!T:&5N(&-H86YG92!24$T@
M*B\*+0D)9&\@>PHM"0D)=3DS at S-SDR9%]U<&1A=3D&5?8VQI96YT*&-L:65N=3D"D[
M"BT)"0EI9B H*&1A=3D&$M/F9A;EMN<ET^,'@U,"D@)B8@*&1A=3D&$M/F9A;EMN
M<ET\,'AF9BDI('L*+0D)"2\J(&]P=3D&EM86P at 8V%S92X@,'@U,"!A;F0@,'AF
M9B!A<F4 at 97AP97)I96YC92!D871A("HO"BT)"0D)<F5S=3D6QT<ULQ72 ]($9!
M3E]&4D]-7U)%1RAD871A+3YF86Y;;G)=3D+ HM"0D)"0D)1$E67T923TU?4D5'
M*&1A=3D&$M/F9A;E]D:79;;G)=3D*2D["BT)"0D)8G)E86L[("\J(&=3DO(&]U=3D"!O
M9B!T:&4 at 9&\M=3DVAI;&4@;&]O<"X@*B\*+0D)"7T at 96QS92!["BT)"0D):68@
M*"@H9&%T82T^9F%N7V1I=3DEMN<ETI/CTP># W("8F"BT)"0D)"2AD871A+3YF
M86Y;;G)=3D*3T],'AF9BD@?'P*+0D)"0D@(" @*"AD871A+3YF86Y?9&EV6VYR
M72D\/3 @)B8*+0D)"0D)*&1A=3D&$M/F9A;EMN<ETI/#!X-S at I*2!["BT)"0D)
M"7)E<W5L=3D'-;,5T@/2 P.PHM"0D)"0EB<F5A:SL*+0D)"0E](&5L<V4@:68@
M*"AD871A+3YF86Y?9&EV6VYR72D\,'@P-R F)@HM"0D)"0D@*&1A=3D&$M/F9A
M;EMN<ETI/3TP>&9F*2!["BT)"0D)"2AD871A+3YF86Y?9&EV6VYR72DK*SL*
M+0D)"0D)<F5S=3D6QT<ULQ72 ]($9!3E]&4D]-7U)%1RAD871A+3YF86Y;;G)M+ HM"0D)"0D)=
(" @("!$259?1E)/35]214<H9&%T82T^9F%N7V1I=3DEMN<ETI
M*3L*+0D)"0E](&5L<V4@:68@*"AD871A+3YF86Y?9&EV6VYR72D^," F)@HM
M"0D)"0D@("AD871A+3YF86Y;;G)=3D*3PP>#<X*2!["BT)"0D)"2AD871A+3YF
M86Y?9&EV6VYR72DM+3L*+0D)"0D)<F5S=3D6QT<ULQ72 ]($9!3E]&4D]-7U)%
M1RAD871A+3YF86Y;;G)=3D+ HM"0D)"0D)(" @("!$259?1E)/35]214<H9&%T
M82T^9F%N7V1I=3DEMN<ETI*3L*+0D)"0E]"BT*+0D)"0ET;7!?<F5G(#T@=3DS at S
M-SDR9%]R96%D7W9A;'5E*&-L:65N=3D"P*+0D)"0D)"5<X,S<Y,D1?4D5'7T9!
M3E]$259;;G(O,ETI.PHM"0D)"71M<%]R96<@)CT@*&YR)3(@/3T@,"D@/R P
M>&8X(#H@,'@X9CL*+0D)"0ET;7!?9F%N7V1I=3DB ]("AN<B4R(#T](# I(#\@
M*&1A=3D&$M/F9A;E]D:79;;G)=3D*0HM"0D)"0DZ("@H*&1A=3D&$M/F9A;E]D:79;
M;G)=3D*3P\-"DF,'@W,"D["BT)"0D)=3DS at S-SDR9%]W<FET95]V86QU92AC;&EE
M;G0L"BT)"0D)"0D@(" @5S at S-SDR1%]214=3D?1D%.7T1)5EMN<B\R72P*+0D)
M"0D)"2 @("!T;7!?<F5G?'1M<%]F86Y?9&EV*3L*+0D)"7T*+0D)?2!W:&EL
M92 H,"D["BL)"0D)"41)5E]&4D]-7U)%1RAD871A+3YF86Y?9&EV6VYR72DI
M.PHK"0ER97-U;'1S6S%=3D(#T at 1D%.7T923TU?4D5'*&1A=3D&$M/F9A;EMN<ETL
M"BL)"0D)"41)5E]&4D]-7U)%1RAD871A+3YF86Y?9&EV6VYR72DI.PHK"0EI
M9B H(2AD871A+3YH87-?9F%N("8@*#$@/#P@;G(I*2D@>PHK"0D)<F5S=3D6QT
M<ULP72 ](# ["BL)"0ER97-U;'1S6S%=3D(#T@,#L**PD)?0H@"0DJ;G)E;'-?
M;6%G(#T@,CL*( E](&5L<V4@:68@*&]P97)A=3D&EO;B ]/2!314Y33U)37U!2
M3T-?4D5!3%]74DE412D@>PH@"0EI9B H*FYR96QS7VUA9R ^/2 Q("8F("AD
M871A+3YH87-?9F%N("8@*#$@/#P@;G(I*2D@>PI 0" M,3$X,RPY("LQ,3DT
M+#<@0$ @<W1A=3D&EC('9O:60@=3DS at S-SDR9%]F86Y?9&EV*'-T<G5C=3D"!I,F-?
M8PH@"0D@(" @(&EN=3D"!C=3D&Q?;F%M92P@:6YT("IN<F5L<U]M86<L(&QO;F<@
M*G)E<W5L=3D',I"B!["B )<W1R=3D6-T('<X,S<Y,F1?9&%T82 J9&%T82 ](&-L
M:65N=3D"T^9&%T83L*+0EI;G0@:3TP+"!J/3 ["BT)=3D3@@=3D&5M<%]R96<],"P@
M:STQ+"!F86Y?9&EV7W)E9STP.PHM"74X('1M<%]F86Y?9&EV.PHK"6EN=3D"!I
M(#T@,#L*( H@"6EF("AO<&5R871I;VX@/3T at 4T5.4T]24U]04D]#7U)%04Q?
M24Y&3RD*( D)*FYR96QS7VUA9R ](# ["D! ("TQ,3DU+#(W("LQ,C T+#8@
M0$ @<W1A=3D&EC('9O:60@=3DS at S-SDR9%]F86Y?9&EV*'-T<G5C=3D"!I,F-?8PH@
M"0D)<F5S=3D6QT<UMI72 ]($1)5E]&4D]-7U)%1RAD871A+3YF86Y?9&EV6VEM*3L*( D)?0H@=
"0DJ;G)E;'-?;6%G(#T at -SL*+0E](&5L<V4@:68@*&]P97)A
M=3D&EO;B ]/2!314Y33U)37U!23T-?4D5!3%]74DE412D@>PHM"0EI9B H*FYR
M96QS7VUA9R \(#<I('L*+0D)"7)E=3D'5R;CL*+0D)?0HM"0EF;W(@*&D],#L@
M:3PW.R!I*RLI('L*+0D)"71E;7!?<F5G(#T at 4T5.4T]24U],24U)5"AR97-U
M;'1S6VE=3D+" Q+" Q,C at I.PHM"0D)9F]R("AK/3 L:CTP.R!J/#<[(&HK*RD@
M>PHM"0D)"71E;7!?<F5G(#T@=3D&5M<%]R96<^/C$["BT)"0D):68@*'1E;7!?
M<F5G(#T](# I"BT)"0D)"6)R96%K.PHM"0D)"6LK*SL*+0D)"7T*+0D)"69A
M;E]D:79?<F5G(#T@=3DS at S-SDR9%]R96%D7W9A;'5E*&-L:65N=3D"P*+0D)"0D)
M5S at S-SDR1%]214=3D?1D%.7T1)5EMI+S)=3D*3L*+0D)"69A;E]D:79?<F5G("8]
M("AI)3(@/3T@,"D@/R P>&8X(#H@,'@X9CL*+0D)"71M<%]F86Y?9&EV(#T@
M*&DE,B ]/2 P*2 _("AK)C!X,#<I"BT)"0D)"3H@*"AK/#PT*28P>#<P*3L*
M+0D)"7<X,S<Y,F1?=3DW)I=3D&5?=3DF%LdH8VQI96YT+ HM"0D)"0E7.#,W.3)$
M7U)%1U]&04Y?1$E66VDO,ETL"BT)"0D)"69A;E]D:79?<F5G?'1M<%]F86Y?
49&EV*3L*+0D)?0H@"7T*('T*( H`
`
end

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileg=
ed confidential information contained in this email is intended for use onl=
y by the addressees as indicated by the original sender of this email. If y=
ou are not the addressee indicated in this email or are not responsible for=
 delivery of the email to such  a person, please kindly reply to the sender=
 indicating this fact and delete all copies of it from your computer and ne=
twork server immediately. Your cooperation is highly appreciated. It is adv=
ised that any unauthorized use of confidential information of Winbond is st=
rictly prohibited; and any information in this email irrelevant to the offi=
cial business of Winbond shall be deemed as neither given nor endorsed by W=
inbond.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DIf your comp=
uter is unable to decode Chinese font, please ignore the following message.=
It essentially repeats the statement in English given above.=A5=BB=ABH=A5=
=F3=A4=BA=A9=D2=A7t=B5=D8=A8=B9=B9q=A4l=AA=BA=B0]=B2=A3=A9=CA=BE=F7=B1K=A9=
=CA=B8=EA=B0T, =B6=C8=B1=C2=C5v=AD=EC=B5o=ABH=A4H=AB=FC=A9w=A4=A7=A6=AC=ABH=
=A4H=A8=FA=BE\\=A4=A7=A5=CE. =B0=B2=A8=CF=B1z=A8=C3=ABD=B3Q=AB=FC=A9w=A4=A7=
=A6=AC=ABH=A4H=A9=CE=A6]=A5=F4=A6=F3=AD=EC=A6]=A6b=A5=BC=B8g=B1=C2=C5v=AA=
=BA=B1=A1=A7=CE=A4=A7=A4U=A6=AC=A8=EC=A5=BB=ABH=A5=F3, =BD=D0=B1z=A7i=AA=BE=
=AD=EC=B5o=ABH=A4H=A8=C3=A5=DF=A7Y=B1N=ABH=A5=F3=B1q=B9q=B8=A3=BBP=BA=F4=B8=
=F4=A6=F8=AAA=BE=B9=A4=A4=A4=A9=A5H=AE=F8=B0=A3. =B9=EF=A9=F3=B1z=AA=BA=A6X=
=A7@, =A7=DA=AD=CC=A5=FD=A6=B9=ADP=C1=C2. =AFS=A6=B9=B4=A3=BF=F4, =A5=F4=A6=
=F3=A5=BC=B8g=B1=C2=C5v=BE=D5=A6=DB=A8=CF=A5=CE=B5=D8=A8=B9=B9q=A4l=AA=BA=
=BE=F7=B1K=B8=EA=B0T=AA=BA=A6=E6=AC=B0=ACO=B3Q=C4Y=AE=E6=B8T=A4=EE=AA=BA. =
=ABH=A5=F3=BBP=B5=D8=A8=B9=B9q=A4l=C0=E7=B7~=B5L=C3=F6=A4=A7=A4=BA=AEe,=A4=
=A3=B1o=B5=F8=AC=B0=B5=D8=A8=B9=B9q=A4l=A4=A7=A5=DF=B3=F5=A9=CE=B7N=A8=A3.


