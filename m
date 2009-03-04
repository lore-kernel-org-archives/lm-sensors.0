From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Mar 2009 21:58:46 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0752 - how can I
Message-Id: <20090304225846.06e08c77@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903041438.45638.zbiggy@o2.pl>
In-Reply-To: <200903041438.45638.zbiggy@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 4 Mar 2009 22:13:35 +0100, Zbigniew Luszpinski wrote:
> Wednesday 04 of March 2009 15:21:47 you wrote:
> > Please send the output of "lspci -vv -s 00:01.1".
>=20
> 00:01.1 SMBus: nVidia Corporation MCP78S [GeForce 8200] SMBus (rev a1)
>         Subsystem: ASRock Incorporation K10N78FullHD-hSLI R3.0 SMBus
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-=20
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 7
>         Region 0: I/O ports at 2900 [sized]
>         Region 4: I/O ports at 2d00 [sized]
>         Region 5: I/O ports at 2e00 [sized]
>         Capabilities: [44] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

This looks reasonably similar to the other SMBus controllers from
nVidia. Are you willing to take your chance?

If you are, here's what you need to do (as root):
# modprobe i2c-nforce2
# echo "10de 0752" > /sys/bus/pci/drivers/nForce2_smbus/new_id
# modprobe i2c-dev
# i2cdetect -l
# i2cdetect <n>
# i2cdetect <n+1>
where <n> and <n+1> are the i2c bus numbers of the two nForce SMBus
channels.

If this gives resonable results I will add the new device ID to the
sensors-detect script and the i2c-nforce2 driver.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
