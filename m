From: timm@fnal.gov (Steven Timm)
Date: Fri, 31 Mar 2006 14:50:39 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <Pine.LNX.4.62.0603310845030.6379@snowball.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 31 Mar 2006, Jean Delvare wrote:

> Hi Dieter,
>
>> I am using several Tyan Tiger 2460 motherboards since quite a while. And=
 I am
>> observing a strange behaviour someone in the list (might) have a clue ab=
out.
>>
>> I am reading the sensors data periodically every 10 seconds. After an
>> undefined time (maybe one week, maybe one day, maybe three weeks) sensors
>> "hangs" after start and cannot be killed any more. A manual call to sens=
ors
>> ends in a hang as well (of sensors, the board is running on).
>>
>> What is my configuration:
>> I am loading
>> MODULE_0=3Di2c-amd756
>> MODULE_1=3Di2c-isa
>> MODULE_2=3Dw83781d
>> MODULE_3=EEprom
>> MODULE_4=3Dw83627hf
>> (in this sequence).
>>
>> By recommendation from Tyan I use the line:
>> options w83781d force_w83782d=3D0,0x2d force_subclients=3D0,0x2d,0x48,0x=
49
>> force_w83627hf=3D0,0x2c force_subclients=3D0,0x2c,0x4a,0x4b init=3D0
>>
>> in /etc/modprobe.conf.local
>
> This doesn't make much sense. You ask the w83781d driver to take care
> of the W83627HF chip, but also load the w83627hf driver. Both drivers
> will attempt to handle the same chip, this might explain the deadlock.

This board and other Tyan boards of that era have actually got two chips,=20
one of which is the W83627HF, and all of them have got some strange
subclients like that which are necessary.  When I was running that
board there was a custom sensors.conf that was necessary too to
interpret the output correctly, the stock one that comes with
the source doesn't cut it.  At that time Tyan had people who
made it for us, not sure if those folks are still with Tyan or not.
On the closely-related tyan 2466 board, I was following what
Jean said and only loading the W83781d driver.  That should work.

Steve


>
> I'd suggest that you try without loading the w83627hf driver. If the
> w83781d driver is able to handle both chips (the W83782D and the
> W83627HF) then the w83627hf driver is not needed at all.
>
>

--=20
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm at fnal.gov  http://home.fnal.go=
v/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Sec=
tion
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team

