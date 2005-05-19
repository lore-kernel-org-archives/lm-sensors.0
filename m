From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: New chip driver development plan to Lm_sensors
Message-Id: <20041205121647.1cea2433.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
In-Reply-To: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

Sorry for the delay, I have been encountering severe mail problems and
lost 6 days worth of data, including your latest request for
information. I finally found it while browsing the mailing-list archive,
so here are my answers.

> I have finished some of the functions in w83792d.c, and can produce
> some device files in directory /proc/sys/dev/sensors/w83792d-i2c-0-2f/
> for example in0.

Great :)

> But each time(except within the interval "HZ + HZ/2") I read the in0 file
> by "cat" command, I find that the delay is comparatively large, which is
> about 1-2 seconds. That's to say it takes me about 1-2 seconds to show me
> the content of "in0", which also leads to the delay of the program "sensors".

This is expected. All reads are grouped in a single function by design,
so updating one value or the whole chip takes the same time.

> I have debugged about it, find that the function "w83792d_update_client"
> is the reason of the delay. Because in the course of the delay, this
> function is executing and reading the registers' value one by one.

True, you got it.

> I also tested another Winbond chip W83627THF with the driver w83627hf.c
> find that this phenomena does NOT exist on W83627THF. That's to say all
> the device files of W83627THF can be read very quickly almost without any
> delay, just like regular text file.

This is due to the speed difference between I2C (SMBus) and ISA. ISA is
really fast, I2C/SMbus is comparatively very slow.

> So my questions are:
> (1) Does this phenomena appears in other I2C chip drivers? such as
> w83781d.c. Because W83627THF use ISA bus instead of I2C.

Yes, that's exactlty it.

> (2) Does it have something to do with the register numbers be read in
> the function " w83792d_update_client()"?
> Because w83792d_update_client read much more registers than w83627hf.

Yes, the time required for one update is naturally proportional to the
number of registers, for a given type of bus (ISA vs I2C). It makes no
sense to compare a N1-register chip on I2C with a N2-register on ISA
though.

> (3) Or does it have something to do with the "w83792d_data->last_updated"
> in the last mail? but there is also "w83627hf_data->last_updated" in
> w83627hf.c, and the interval is same: HZ + HZ/2

This isn't. HZ + HZ/2 defines the minimal delay between two updates (1.5
second in this case). However, it makes sense to define a larger delay
if the chip is slow updating, both for security/stability and user
experience reasons.

> (4) I also have tried to split the codes of w83792d_update_client()
> into indivial function, for example: I move the following codes from
> w83792d_update_client() into the function w83792d_in(), and comment
> out the " w83792d_update_client()" in w83792d_in(), but it seems
> useless, because the delay becomes more larger.:-(
> 
> ************ codes be moved  ******************
> data->in[0] = w83792d_read_value(client, W83792D_REG_IN0);
> data->in[1] = w83792d_read_value(client, W83792D_REG_IN1);
> data->in[2] = w83792d_read_value(client, W83792D_REG_IN2);
> data->in[3] = w83792d_read_value(client, W83792D_REG_IN3);
> data->in[4] = w83792d_read_value(client, W83792D_REG_IN4);
> data->in[5] = w83792d_read_value(client, W83792D_REG_IN5);
> data->in[6] = w83792d_read_value(client, W83792D_REG_IN6);
> data->in[7] = w83792d_read_value(client, W83792D_REG_IN7);
> data->in[8] = w83792d_read_value(client, W83792D_REG_IN8);

By doing that you remove the effect of caching for these registers. This
won't speed up the single-register reads, but will significantly slow
"sensors" down. Also, it breaks our security model. Don't do that. No
register read should happen outside of the update function (except in
the init function when loading the driver, granted).

The SMBus is slow, we have to live with it ;)

One possibility is to have two different minimal delays between updates,
one for measured values and one (longer) for values that supposedly
don't change (such as limits and config). I think that only the lm85
driver is doing it this way so far, take a look there. For a chip with a
very high number of registers, that may make sense.

Another possibility is to use I2C/SMBus block reads. However:

1* The W83792D would need to support it, I don't know if it is the case.

2* Not all SMBus master chips support it, so the w83792d driver would
still have to support the byte/word read method for those who don't.

3* Block reads have not been much tested so far so it might not be a
good idea for you to rely on them. You would better get the driver
working with regular byte/word reads first. Block reads can be added
later (providing the W83792D supports them, that is).

A third possibility would be to use SMBus direct byte reads instead of
data byte reads, but this requires that the W83792D has autoincrement
registers. Without a datasheet I of course cannot tell whether this is
the case or not.

Please do not hesitate to share your code with us as soon as you get
something working, so that we can comment on it and users can start
testing it too.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
