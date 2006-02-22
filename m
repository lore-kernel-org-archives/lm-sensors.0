From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 22 Feb 2006 03:28:01 +0000
Subject: [lm-sensors] infinite loop during 2.10.0 compilation
Message-Id: <191fb4ca0602211928l20b4cdcdq45a377e8380e425c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191356u1b0e19dq1729de2b1b9649c9@mail.gmail.com>
In-Reply-To: <191fb4ca0602191356u1b0e19dq1729de2b1b9649c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Well, uhmm, this is emberassing :-)
I *did* check the date but never bothered to look at the year. Don't
know how it got set to 2000.
I fixed the date and it compiles cleanly now.

Sorry about that.

...juerg


>
> Hi Juerg,
>
>> I'm trying to build lm_sensors-2.10.0 (kernel 2.6.16-rc3-mm1) but the
>> compile process goes into an infinite loop.
>>
>> Any ideas what's going on?
>> (...)
>> make: Warning: File `etc/Module.mk' has modification time 1.2e+08 s in
>> the future
>
> Check your system date, you seem to leave 4 years in the past. You won't
> be able to build anything until your system date is correct.
>
> --
> Jean Delvare
>

