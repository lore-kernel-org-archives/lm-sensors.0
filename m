From: andreas@schutz.se (andreas@schutz.se)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: parport driver
Message-Id: <33080.83.233.14.177.1113768675.squirrel@webmail1.b-one.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again!
So I tried to load the following modules: i2c_core, i2c_algo_bit,
i2c_pport, i2c_dev, i2c_sensor, pcf8574.
Should I be able to se my pcf8574 chip that is hooked up on my parallel
port now? Cause I can not! Do I have to consider cables (length and
others) or have I done anything else wrong? Some hints on trouble shooting
would be apreciated.

Thanks.


/Andreas



> Hi Andreas,
>
>> Must confess that I am a little confused though, and the more I read
>> the more insecure I get. Seems like Jean boiled the paralell port
>> drivers (5) together some day back in 2003? Is that correct? What
>> actually happened with the different access modes? Exactly what
>> modules do I need to load to get my parallell port lines to speak i2c?
>
> My unified i2c-parport driver handles all i2c-over-parallel-port devices
> *except* the ones which have no electronics needed, which are handled by
> i2c-pport (not in the kernel tree yet) which you just compiled. So go
> with i2c-pport and don't use i2c-parport.
>
> Providing that your pin wiring is correct, you should now be able to
> drive whatever chip you connected to your bus using any of the various
> chip drivers we have. Or you can test the bus using the i2cdetect
> userspace tool. Or you can write your own userspace tool to have the i2c
> bus do whatever you want. Which chips do you plan to connect on that
> bus, BTW?
>
> --
> Jean Delvare
>

