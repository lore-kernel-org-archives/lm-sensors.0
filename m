From: "Manuel Lamotte-Schubert" <mls@pronego.com>
Date: Thu, 14 Jan 2010 18:24:53 +0000
Subject: ***SPAM (-3.0)*** Re: Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <76d45646bf33239e7a00463b16aa9c34.squirrel@mail.pronego.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> Hi Manuel,
>
> On Thu, 14 Jan 2010 18:49:27 +0100, Manuel Lamotte-Schubert wrote:
>> I've downloaded the 2.6.33-rc4 kernel and integrated your patch.
>> Please note, that I could not apply the patch automatically.
>> I had to apply it by hand because the line numbers from the patch file
>> didn't match the numbers in the target files.
>
> I'm surprised. For one thing, "patch" is smart and can apply patches
> even when line numbers don't match. For another, my patch was generated
> exactly on top of 2.6.33-rc4, so it should have applied perfectly.

The response from the patch program was something like "Patch failed" and
it created the rejected files lm90.c.rej and KConfig.rej.

>> Which tests shall I run now?
>
> Just load the lm90 driver then run "sensors", you should see an entry
> for the W83L771 with two temperature. temp1 would be the board
> temperature and temp2 the CPU temperature.

Thats what I have already did but I was confused about the messages.
Here's the output:

# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +52.0=B0C  (crit =3D +90.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +52.0=B0C  (crit =3D +90.0=B0C)

w83l771-i2c-0-4c
Can't get adapter name
temp1:       +51.0=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
                      (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
temp2:       +68.5=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
                      (crit =3D +110.0=B0C, hyst =3D +100.0=B0C)

I guess, the values temp1 and temp2, respectively, below the
w83l771-i2c-0-4c are the board and CPU temperature.
But what are the other temperatures, core 0 and core 1?

Yet another question: will the patch be automatically integrated into the
next kernel version or was it something special for me?
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

Best regards,
Manuel Lamotte-Schubert


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
