From: Jiri Horky <jiri.horky@gmail.com>
Date: Sun, 05 Apr 2009 07:55:28 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <49D863F0.3000803@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I too have Intel DG45FC board and I am very interested in getting
sensors working (and even more in PWM control of board, I am able to
monitor temperatures with external thermometer). From what I understand,
it would require "QST SDK" from Intel to be realeased, am I right (does
that apply to PWM control too?) ? See [1].

And to answer Jean Delvare question. I have tried mentioned
sensors-detect and the output was:

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Driver `lm85':
  * Bus `SMBus I801 adapter at f000'
    Busdriver `i2c_i801', I2C address 0x2e
    Chip `lm85' (confidence: 6)


Jiri Horky

[1]
http://software.intel.com/en-us/forums/manageability-software-development/topic/54851/



> OK, thanks for the information. This confirms my guess that devices
> without the hardware monitoring block have revision ID 0x91. Please
> give a try to the latest version of sensors-detect:
> http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
>
> It should detect a WPCD376I/377I and tell you it doesn't have hardware
> monitoring features.
>
> -- 
> Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
