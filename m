From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 19 Feb 2006 22:02:57 +0000
Subject: [lm-sensors] infinite loop during 2.10.0 compilation
Message-Id: <M4RJ4BZV.1140386577.7888940.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191356u1b0e19dq1729de2b1b9649c9@mail.gmail.com>
In-Reply-To: <191fb4ca0602191356u1b0e19dq1729de2b1b9649c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Juerg,

> I'm trying to build lm_sensors-2.10.0 (kernel 2.6.16-rc3-mm1) but the
> compile process goes into an infinite loop.
>
> Any ideas what's going on?
> (...)
> make: Warning: File `etc/Module.mk' has modification time 1.2e+08 s in
> the future

Check your system date, you seem to leave 4 years in the past. You won't
be able to build anything until your system date is correct.

--
Jean Delvare

