From: william@wschnell.ca (William)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: temperatures
Message-Id: <opr9qpw8r1lsrnb1@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr9pzmdztlsrnb1@localhost>
In-Reply-To: <opr9pzmdztlsrnb1@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf;
There is no /etc/modules in my OS.
I'm wondering if it should be pasted into the specified folder as  
something other than a text file. I don't yet know how to do this.
William



On Thu, 17 Jun 2004 08:59:59 +0200 (CEST), Rudolf Marek  
<R.Marek@sh.cvut.cz> wrote:

>
> Hello
>
> Please notice after sensors-detects exits, there is displayed which
> modules you should load. Cut and paste this to /etc/modules, which is the
> file for autoloadning modules on startup for most GNU/Linux  
> distributions.
>
> I hope this help for now.
>
> Please cc to list too.
>
> Thanks
>
> Regards
>
> Rudolf
>
> On Wed, 16 Jun 2004, William wrote:
>
>> Hello;
>> I've just now installed gkrellm (i2c and lm_sensors) in a new  
>> slackware9.1.
>> When finished with sensors-detect I ran "sensors" and was pleased to see
>> lots of stuff.
>> Since rebooting, I have no temperatures, and running "sensors" gets me  
>> "no
>> sensor found!"
>> I suspect it's where I put the modprobe stuff in /etc/rc.d/init.d;  
>> advice
>> on how and where to put it would be welcome.
>> Hope that's it.
>> William
>>
>>
>> --
>> Using Opera's revolutionary e-mail client: http://www.opera.com/m2/
>>
>>



-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/m2/
