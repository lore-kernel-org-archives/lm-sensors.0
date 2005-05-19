From: tnuro@yahoo.com.au (TN)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: ticket 1415
Message-Id: <3F971822.6070501@yahoo.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F95168B.5040305@yahoo.com.au>
In-Reply-To: <3F95168B.5040305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

>* Mark M. Hoffman <mhoffman@lightlink.com> [2003-10-21 12:53:35 -0400]:
>  
>
>>Well, libsensors is indeed missing some code to support it - but that's as
>>far as I got.  I'll try to commit something to CVS tonight.
>>    
>>
>
>"It" is w83627thf...
>
>OK, I committed a partial fix - go ahead and try it.  I already see that
>sensors doesn't report fan3 (which corresponds to "Power Fan" in P4C800
>BIOS.)  I will start another thread on the mailing list about that...
>
>Regards,
>
>  
>

Hi Mark,

success.......I got the latest from cvs and sure enough, numbers! I'm 
not sure about a couple of these (ie. the voltage sensors seem to have 1 
or 2 weirdnesses about them), but it appears to be working. The fan 
speed & temperatures seem to make sense and change in a sensible manner 
(speed increases as temperature increases)

One thing I've noticed is that on my physically accessible servers, the 
temp readings seldom agree with the bios readings.....is there a 
calivration process I need to go through ?

Anyway, thanks again for listening.
-Trevor.



fw:~# sensors
w83627thf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
in0:       +2.89 V  (min =  +0.00 V, max =  +0.00 V)
in2:       +3.23 V  (min =  +2.97 V, max =  +3.63 V)
in3:       +2.97 V  (min =  +2.68 V, max =  +3.26 V)
in4:       +0.00 V  (min =  +0.08 V, max =  +1.34 V)
in7:       +2.94 V  (min =  +2.68 V, max =  +3.26 V)
in8:       +3.23 V  (min =  +2.70 V, max =  +3.29 V)
fan1:        0 RPM  (min =  187 RPM, div = 32)
fan2:     3214 RPM  (min = 3000 RPM, div = 2)
temp1:       +32?C  (limit =  +60?C)                       sensor = 
thermistor
temp2:     +37.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
PII/Celeron diode
alarms:
beep_enable:
          Sound alarm disabled



