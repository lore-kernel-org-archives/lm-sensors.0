From: Zbigniew Luszpinski <zbiggy@o2.pl>
Date: Wed, 04 Mar 2009 21:13:35 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0752 - how can I
Message-Id: <200903042213.35785.zbiggy@o2.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903041438.45638.zbiggy@o2.pl>
In-Reply-To: <200903041438.45638.zbiggy@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Wednesday 04 of March 2009 15:21:47 you wrote:
> Please send the output of "lspci -vv -s 00:01.1".

00:01.1 SMBus: nVidia Corporation MCP78S [GeForce 8200] SMBus (rev a1)
        Subsystem: ASRock Incorporation K10N78FullHD-hSLI R3.0 SMBus
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at 2900 [sized]
        Region 4: I/O ports at 2d00 [sized]
        Region 5: I/O ports at 2e00 [sized]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

have a nice day,
Zbigniew 'zbiggy' Luszpinski

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
