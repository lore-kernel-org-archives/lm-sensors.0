From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Tue, 12 May 2009 18:57:07 +0000
Subject: Re: [lm-sensors] 5VSB computing on it87
Message-Id: <4A09C683.4050101@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
In-Reply-To: <BLU120-W7191DFD982F4E48F88CBAD8630@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/12/09 10:55, Mr. Tux wrote:
> Thank you Jean
> 
> So, this sensor is not assigned correctly, I could life with that for the moment, but my problem
> is the alarm flag this sensors is causing, since the value for some reason is saturated.
> 
> I'd like to put this sensor on ignore for the moment, but I don't know how to do that:
> 
> *) ignore in7 - only prevents the sensor to be listed using the 'sensors' command
> *) comment every line mentioning in7 in sensors3.conf - makes it appear under
> /sys/devices/plattform/[...]/ anyway ! With the alarm flag in "in7_alarm" set to 1 - I need to get rid
> of that...
> *) trying to set in7 to value 0 (= unused): 'set in7_type  0' causes a parse error with 'sensors -s'
> *) trying to raise the max_value barrier switching on the alarm: 'set in7_max    7 * 1.05'
> this does not have an effect - the max limit stays at 6,.85, triggering the alarm!
> 
> What else can I try? I need the alarm flag in /sys/devices/plattform/[...]/in7_alarm to
> be set to '0' - since I'm writing a small daemon who will parse for alarm values
> only, starting a speaker beep when a alarm is discovered.
> 
> Thanks in advance for any help.
> 
> Mr Tux

Sir,

  If you don't come up with a better solution, I parse the output of the
'sensors' command and look for alarms. I just run the command once a minute
(I think that's the current rate) and send an e-mail when an alarm is
detected.

  I just 'ignore' (in7 in your case) in the sensors.conf file, by the way,
for any inputs I don't want to see in the 'sensors' output.

YMMV.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
