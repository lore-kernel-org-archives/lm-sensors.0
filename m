From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 06 Oct 2009 14:30:13 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] asus_atk0110: refactor and support for
Message-Id: <68676e00910060730i45f5a4d1w93cb7db8b5d64eda@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091006115023.697932717@gmail.com>
In-Reply-To: <20091006115023.697932717@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Oct 6, 2009 at 4:10 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Luca,
>
> On Tue, 06 Oct 2009 13:50:23 +0200, Luca Tettamanti wrote:
>> Hello Jean,
>> I'm sending two patches for asus_atk0110:
>> - the first one is mostly refactoring to allow easier extension of the d=
river;
>> =C2=A0 it also extends GITM to handle buffers larger than 8 bytes.
>> - the second one add support for enabling/disabling EC
>
> I've applied both patches. Should I delay them until kernel 2.6.33, or
> is it desirable (and safe) to have them in kernel 2.6.32?

The driver as-is loads fine on newer board but spams the log with
failure messages (fixed by the first patch).
The patch that might cause problem is the second one (I've kept the
patch separated and bisectable for this reason); however without that
patch users with new boards won't get updated readings.
So I'd say that it's desirable to have both of them in 2.6.32.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
