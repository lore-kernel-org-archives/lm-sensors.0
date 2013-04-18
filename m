From: Adam Rosi-Kessel <adam@rosi-kessel.org>
Date: Thu, 18 Apr 2013 14:50:01 +0000
Subject: Re: [lm-sensors] Dell Inspiron 530 Chassis Fan Control?
Message-Id: <51700819.6070805@rosi-kessel.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1874334270924131675=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130316175820.GA979@whitehail.bostoncoop.net>
In-Reply-To: <20130316175820.GA979@whitehail.bostoncoop.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============1874334270924131675==
Content-Type: multipart/alternative;
 boundary="------------070506060405000404040105"

This is a multi-part message in MIME format.
--------------070506060405000404040105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/2013 6:59 PM, Guenter Roeck wrote:
>>>>> > > >>Sorry -- typo above. It should say I can control*CPU*  fans, but can't
>>>>> > > >>find any documentation as to how to control the*chassis*  fan.
>>>> > > >On my motherboard, all fan headers have 4 pins, but there is a jumper
>>>> > > >to tell the board to treat the case fan headers as 3-pin. This is
>>>> > > >rather rare though, most motherboards have it hard-wired
>>> > >Thanks. I will check this. Before I open up my case, is there anywhere I
>>> > >can/should look in log files or /sys to see if the chassis fan is
>>> > >controllable? Would this be found in a different place than the CPU fans?
>> >
>> >No, it can't be seen from the logs nor /sys. Only hardware inspection
>> >can tell you, and not even in all cases.
>> >
> Inspiron 530 manual (downloadable) says that the processor fan has a 4-pin
> connector and the chassis fan has a 3-pin connector.
Apologies as this a bit OT, but hoping someone can help me understand 
what's happening here. It does appear that the Inspiron has a 3-pin 
connector. When I power up the box, it is very quiet for about 4 or 5 
minutes. After that, the fan appears to go to 100% and never quiets down 
again. Even when I cpufreq-set to powersave and cap the max CPU freq at 
2.0 GHz for all four cores (80% of max), it still stays loud 
indefinitely. I've opened up the box and cleaned out all dust and 
visually inspected the fans, and nothing appears awry. 
/sys/devices/virtual/thermal/thermal_zone0/temp consistently reports 
40.0 degrees C i.e. 40000 (I'm actually suspicious of that number 
because it never seems to change). Any ideas for what I can do to 
troubleshoot why the fan is always running at full blast?

Adam

--------------070506060405000404040105
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 3/16/2013 6:59 PM, Guenter Roeck
      wrote:<br>
    </div>
    <blockquote cite="mid:20130316225948.GA23321@roeck-us.net"
      type="cite">
      <blockquote type="cite" style="color: #000000;">
        <blockquote type="cite" style="color: #000000;">
          <blockquote type="cite" style="color: #000000;">
            <blockquote type="cite" style="color: #000000;">
              <pre wrap=""><span class="moz-txt-citetags">&gt; &gt; &gt;&gt; </span>Sorry -- typo above. It should say I can control <b class="moz-txt-star"><span class="moz-txt-tag">*</span>CPU<span class="moz-txt-tag">*</span></b> fans, but can't
<span class="moz-txt-citetags">&gt; &gt; &gt;&gt; </span>find any documentation as to how to control the <b class="moz-txt-star"><span class="moz-txt-tag">*</span>chassis<span class="moz-txt-tag">*</span></b> fan.
</pre>
            </blockquote>
            <pre wrap=""><span class="moz-txt-citetags">&gt; &gt; &gt; </span>On my motherboard, all fan headers have 4 pins, but there is a jumper
<span class="moz-txt-citetags">&gt; &gt; &gt; </span>to tell the board to treat the case fan headers as 3-pin. This is
<span class="moz-txt-citetags">&gt; &gt; &gt; </span>rather rare though, most motherboards have it hard-wired
</pre>
          </blockquote>
          <pre wrap=""><span class="moz-txt-citetags">&gt; &gt; </span>Thanks. I will check this. Before I open up my case, is there anywhere I 
<span class="moz-txt-citetags">&gt; &gt; </span>can/should look in log files or /sys to see if the chassis fan is 
<span class="moz-txt-citetags">&gt; &gt; </span>controllable? Would this be found in a different place than the CPU fans?
</pre>
        </blockquote>
        <pre wrap=""><span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>No, it can't be seen from the logs nor /sys. Only hardware inspection
<span class="moz-txt-citetags">&gt; </span>can tell you, and not even in all cases.
<span class="moz-txt-citetags">&gt; </span>
</pre>
      </blockquote>
      <pre wrap="">Inspiron 530 manual (downloadable) says that the processor fan has a 4-pin
connector and the chassis fan has a 3-pin connector.</pre>
    </blockquote>
    Apologies as this a bit OT, but hoping someone can help me
    understand what's happening here. It does appear that the Inspiron
    has a 3-pin connector. When I power up the box, it is very quiet for
    about 4 or 5 minutes. After that, the fan appears to go to 100% and
    never quiets down again. Even when I cpufreq-set to powersave and
    cap the max CPU freq at 2.0 GHz for all four cores (80% of max), it
    still stays loud indefinitely. I've opened up the box and cleaned
    out all dust and visually inspected the fans, and nothing appears
    awry. /sys/devices/virtual/thermal/thermal_zone0/temp consistently
    reports 40.0 degrees C i.e. 40000 (I'm actually suspicious of that
    number because it never seems to change). Any ideas for what I can
    do to troubleshoot why the fan is always running at full blast?<br>
    <br>
    Adam<br>
  </body>
</html>

--------------070506060405000404040105--


--===============1874334270924131675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1874334270924131675==--
