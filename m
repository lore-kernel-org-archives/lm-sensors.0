From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 28 Oct 2005 20:14:19 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <43626A6C.3020305@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Hans,

>> But certainly, having a kernel driver output 0-255 for a voltage input is
>> a huge and unacceptable step backwards.  Please fix that first and then
>> we can talk about the rest.
I agree completely.

But I have a proposal to solution.

All we just need to know is the how many volts are used for one bit.
http://www.winbond.com/e-winbondhtm/partner/PDFresult.asp?Pname=926

Some suggestions are here around page 64.

And some information are here:

+ label in0 "CPUcore"
+   compute in0 @*0.0137 , @/0.0137
+   label in1 "DDRVdd"
+   compute in1 @*0.0137 , @/0.0137
+   label in7 "Vdd5V"
+   compute in7 @*0.0245 , @/0.0245

VCore is often unscaled so this *0.0137 gives for 8bit =3D>  3.4935Vref so =
3.5V

Rest is simple: just compute the correct divisors for each in0
0.0245/0.0137 is round 2 so 5V might be scaled by 2. I dont know how those =
values were obtained so I cant do more speculations.

Best would be if could measure actual voltage on pin P3REF so pin50 of the =
chip. Also there is another Vref at pin 72 the datasheet
is unclear what pin is used when. If you are measuring please measure actua=
l chip VCC too. (This should be 5V)

How to measure:

Multimeter 0-5V DC
one wire to selected pin, second wire try the black wire of 4 hole power co=
nnector. Try not to shortcut the pins around.
You can take a needle and glue it with the tape to multimeter probe.

Thanks

Regards
Rudolf
