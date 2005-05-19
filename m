From: andreas@schutz.se (andreas@schutz.se)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: parport driver
Message-Id: <2259.193.180.228.194.1112682343.squirrel@webmail1.b-one.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0503101052200.25688@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean!
My project is to make a new implementation of my ha-server. The server is
measuring daylight, external temp. and internal temp. through the game
port and use the data to control heating, light and cars on my estate. As
soon as I have built the wind speed sensor that will be added to.
I will start with several pcf8574 on the i2c bus (parallell port) to
exchange the control functionality I have today (direct driven from the
parallell port) the pcf8574's should also give me some digital inputs to
fiddle with.

Thanks a lot for your answer.

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

