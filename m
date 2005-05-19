From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: New chip driver development plan to Lm_sensors
Message-Id: <IPG7WNN6.1103618257.0206280.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
In-Reply-To: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> Quoting Jean:
> > No register read should happen outside of the update function
> > (except in the init function when loading the driver, granted).
>
> But in kernel/chips/w83781d.c
> I find that there are some "w83781d_read_value" in the following
> functions:
> w83781d_beep()
> w83781d_fan_div()
> w83781d_pwm()
> w83781d_sens()
> when these functions do the "write" operations, which are outside
> the update function.
>
> So my questions are:
> (1) Is it improper for w83781d to use "w83781d_read_value" in that
> way?

No, it is correct. My statement wasn't very clear. What must *not* be
done is allow a regular user to generate I2C traffic outside of the
update function (because we can use the cached values to skip repeated
reads in the update function, but hardly outside).

Using i2c reads for write operations is fine, because only root can run
these write functions (and we assume root knows what he/she's doing).

> (2) In w83792d.c, there are also many places where call the
> w83792d_read_value() function outside w83792d_update_client() when
> dealing with the "write" operation, which is similar with the above
> situation in w83781d.c
> Need I modify the source into using the member of struct w83792d_data?

No, you don't need to modify your code.

Thanks,
--
Jean Delvare
