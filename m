From: Achim Gottinger <achim@ag-web.biz>
Date: Mon, 05 May 2008 19:44:35 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <481F63A3.3030006@ag-web.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:
> Hi Achim,
>
> On Mon, 05 May 2008 14:15:34 +0200, achim wrote:
>  =20
>> He He, the BKDG is tough to read. I tried to figure out the SMbus
>> adresses.
>>
>> http://www.abload.de/image.php?img=BAredit-sidebandeis.jpg
>>
>> This is the register where the adress should be in bits 4:6 whom are all
>> zero. However bit 3 is set and that should mean that the sideband
>> interface is used.
>>
>> http://www.abload.de/image.php?img=3Dsidebandumy.jpg
>>    =20
>
> This isn't how I read the specification. Bit 3 set means that the SBI
> is _disabled_. But it your case, bit 3 is _not_ set, is it?
>
> I wonder where the 4 higher SMBus address bits are set.
>
>  =20
Yepp it's unset means SBI is enabled. Can be a bios issue that the=20
correct address does not shop up here.
That board also does strange things with the cpu and nb vid. No matter=20
what i set in the bios the current-p-state register allways
shows 1.3V. The sensor-chip reads the correct values.
The voltage register works to set p-states. I tweaked the p-state-0 and=20
p-state-1 registers once in a way that CnQ worked with
400MHz at 0.8V in idle and 2.6GHz at 1.4V under load. With CnQ enabled=20
it uses the vid's from those two registers (per cpu).

I'd love to get the readings of those SVI SMbus interfaces. That way it=20
should be possible to read the current northbridge (on chip) voltage,=20
whom is not accessible via the sensor-chip and i can verify that voltage=20
only with an DMM at the moment.
> So there must be yet another chip which doesn't like being probed. This
> confirms my impression that the safest fix is to blacklist the
> motherboard and disable the SMBus entirely. Although I understand that
> you don't want to do this now, as you are still investigating
It's i2cdetect 0 itself. I need to reboot after i ran this to dump the=20
special chips. Otherwise I only get XX's. This issue only occures with=20
the phenom and not with the X2 cpu.
All chips beside those at 0x2e,0x47 and 0x6e can be fully dumped without=20
causing the XX-issue.
Today I wrote a long problem report for the sapphire support and asked=20
them what chip they use at 0x2e. Hope they will shed some light on this=20
issue.
I'll post their response here.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
