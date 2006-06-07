From: sylvain@gomjabbar.ath.cx (Sylvain Jeaugey)
Date: Wed, 07 Jun 2006 22:13:39 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <Pine.LNX.4.62.0606080003380.1376@gomjabbar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

I tested the module with your script. Here's the output :
* WARNING: This will run your system fans through many possible
            combinations. There is a possibility your system will
            overheat. Use this script at your own risk!
Mapping fans...setting all PWMs to 100%
     fan 1 2083 RPM:
         pwm1 RPM highly variable? ignored.
         pwm2 2136 RPM
         pwm3 2109 RPM
     fan 2 3668 RPM:
         pwm1 3668 RPM
         pwm2 1140 RPM: connected.
         pwm3 3668 RPM
     fan 3 0 RPM: ignored. (Fan not installed?)
Testing fan 2 - pwm2 ... div OK, PWM/DC OK
Failure: 50% 3479 RPM, disabled (100%) 3515 RPM.

Fan 1 is my PSU fan, reporting (sometimes crazy) values, but not powered 
my the motherboard. Thus, fan control won't affect it. It's perfectly 
normal.

pwm2 seem to perfectly control my CPU fan (fan2). I was very surprised 
when my CPU fan (normaly running at 20%) started to run at full power !

I'll receive another fan tomorrow, and will connect it to fan1 (and this 
time, it may be controlled by the w83627ehf).
I'll keep you informed. Thanks a lot for your work ! I was _really_ 
waiting for this feature !

Cheers,
Sylvain

Note : to pass the files verification phase, I had to change
ls -l | cut -c-28,42- | (
into
/bin/ls -l | cut -c-28,46- | cut -c-11,13- | (
to make it look like what you expected. Looks like ls hasn't a 
standard output among distros.

On Wed, 7 Jun 2006, David Hubbard wrote:

> Hi Rudolf,
>
> I like the added mutex locking. It's a good idea. It sounds like
> you'll be modifying it a little?
>
> Here is the output of the regression test on my machine:
> # ./w83627ehf_regression.sh
> * WARNING: This will run your system fans through many possible
>          combinations. There is a possibility your system will
>          overheat. Use this script at your own risk!
> Mapping fans...setting all PWMs to 100%
>   fan 1 0 RPM: ignored. (Fan not installed?)
>   fan 2 0 RPM: ignored. (Fan not installed?)
>   fan 3 3479 RPM:
>       pwm1 3443 RPM
>       pwm2 3443 RPM
>       pwm3 1654 RPM: connected.
> Testing fan 3 - pwm3 ... div OK, PWM/DC OK, enable OK
> test_smartfan1 $1="3" $2="pwm3"
> , SF1 OK
>
> Obviously, I'm right in the middle of building SmartFan 1 testing. It
> doesn't test that. Everything else works fine. I'm attaching the
> regression test which is updated for this patch. So, sign me off on
> it.
>
> Thanks,
> David
>

