From: "everythingsfree@lineone.net" <everythingsfree@lineone.net>
Date: Sat, 18 Jun 2011 11:39:38 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <28428685.425911308397178406.JavaMail.defaultUser@defaultHost>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I did as you ask but the values being returned were no 
different to those before.  I checked with 'top' to make sure the CPU 
was being loaded and sure enough there were four 'md5sum' processes 
running at 100%, it also reported that the 'Cpu(s)' were around 92%us 
(oddly it only reported one line for the CPUs when I expected two lines 
for each core at least, perhaps even four lines given hyper-
threading).  I let it run for ten minutes just to be sure.

Hope that 
helps.

Cheers,
Dave


>----Original Message----
>From: khali@linux-fr.
org
>Date: 18/06/2011 8:34 
>To: "Dave"<everythingsfree@lineone.net>

>Cc: <guenter.roeck@ericsson.com>, <lm-sensors@lm-sensors.org>, 
"Durgadoss R"<durgadoss.r@intel.com>, "Yu, Fenghua"<fenghua.yu@intel.
com>
>Subj: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
>
>Hi 
Dave,
>
>On Sat, 18 Jun 2011 04:58:51 +0100 (BST), 
everythingsfree@lineone.net wrote:
>> I've installed and set-up msr-
tools after a quick look on-line 
>> on how to do so ('sudo apt-get 
install msr-tools' followed by 'sudo 
>> modprobe msr', let me know if 
that's missing something) and I get the 
>> following for your 
commands:
>> 
>> $ sudo rdmsr -p 0 -x 0x19c
>> 8600000
>> $ sudo rdmsr -
p 1 -x 0x19c
>> 8630000
>> $ sudo rdmsr -p 2 -x 0x19c
>> 8630000
>> $ 
sudo rdmsr -p 3 -x 0x19c
>> 8600000
>> 
>> Hope that helps.
>
>The 
valid reading bit (31) is indeed never set, which is why the driver

>returns an error (and in turn "sensors" returns N/A.)
>
>The readings 
themselves don't look good anyway. 0x60 and 0x63 would
>translate to 
offset values of 96 and 99, respectively. With a critical
>limit at 100°
C, that would lead to readings of 4°C and 1°C,
>respectively, which is 
obviously incorrect.
>
>I am wondering if maybe the valid reading bit 
gets cleared when the
>measured temperature is too low, because it is 
known that the
>reliability and accuracy of the digital thermal sensor 
get very poor
>when too far below the critical limit. Durgaross, 
Fenghua, do you know
>if this is the case? The CPU in question is an 
Atom D525 (family 6,
>model 28, stepping 10).
>
>Dave, please try 
putting as much load as possible on your CPU (e.g. by
>running "md5sum 
/dev/zero" 4 times in parallel), and then run the rdmsr
>commands 
again, every 20 seconds or so, for 5 minutes. It will be
>interesting 
to see if the readings decrease (meaning higher
>temperatures over 
time) and if the valid reading bit will get set at
>some point.
>
>When 
done, don't forget to kill the md5sum commands ;)
>
>-- 
>Jean Delvare

>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
