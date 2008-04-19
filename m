From: "Fred R. Beck" <beckfr@comcast.net>
Date: Sat, 19 Apr 2008 15:53:11 +0000
Subject: Re: [lm-sensors] AMD K10 (Phenom) Sensor Module
Message-Id: <480A1567.8050305@comcast.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3313535229009495851=="
List-Id: <lm-sensors.vger.kernel.org>
References: <47642FDA.6000801@cox.net>
In-Reply-To: <47642FDA.6000801@cox.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============3313535229009495851==
Content-Type: multipart/alternative;
	boundary="------------000706010001020802050602"

This is a multi-part message in MIME format.
--------------000706010001020802050602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the clues!  I will send a configuration when I get there.

I agree with your note about combining drivers.  That is exactly why I 
was initially taking that path.  Basically, the only differences between 
the k8temp and new k10temp drivers are on the number of thermistors and 
how the temperature is calculated.  Since the probe for CPUID is easy 
enough, I felt that there was benefit.  That said, it was easy enough to 
just have a k10temp as well - which is where I am now.

Thanks again,

Fred

Jean Delvare wrote:
> Hi Fred,
>
> On Fri, 18 Apr 2008 23:44:31 -0600, Fred R. Beck wrote:
>   
>> I've been tied up and just got back to this.  Thanks much for the 
>> "stripped down" version.  It looked much like my last attempt though I'd 
>> missed on some of the registers...  I think you are right, this is 
>> simple enough that there isn't much sense in combining the two drivers, 
>> so I'll scrap that...
>>     
>
> The main decision factor for combining support for several chips in a
> single driver or not is not how simple they are but how similar they
> are to each other.
>
>   
>> (...)
>> So, running sensors now gives:
>>
>>     # modprobe k8temp
>>     # sensors
>>     it8718-isa-0228
>>     Adapter: ISA adapter
>>     in0:       +1.07 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in1:       +1.90 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in2:       +3.38 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in3:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in4:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in5:       +3.25 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in6:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in7:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)  
>>     in8:       +3.07 V
>>     fan1:     1859 RPM  (min =   10 RPM)                  
>>     fan2:        0 RPM  (min =    0 RPM)                  
>>     fan3:        0 RPM  (min =    0 RPM)                  
>>     fan5:        0 RPM  (min =    0 RPM)                  
>>     temp1:       +39 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor  
>>     temp2:       +41 C  (low  =  +127 C, high =   +70 C)   sensor = diode  
>>     temp3:       +84 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor  
>>     vid:      +0.000 V
>>
>>     k10temp-pci-00c3
>>     Adapter: PCI adapter
>>
>> As you can see, I'm still figuring out how to configure lm_sensors for 
>> my GA-MA790FX-DS5...  However, temp1 looks ok and matches what I'm 
>> seeing in the BIOS.
>>     
>
> Here's my guess for voltages if it helps you:
> in0: Vcore
> in1: Vram (although a bit high, should be 1.8)
> in2: +3.3V
> in3: +5V with scaling factor 1.68
> in4: +12V with scaling factor 4
> in5: 3VSB or 5VSB with a scaling factor of 1.68
> in6: unused
> in7: unused
> in8: Vbat
>
> Please check your logs after loading the it87 driver, it might give
> hints about in3 and in7.
>
> If your BIOS displays voltage values, compare with those to validate
> your lm-sensors configuration settings.
>
> As for temperature, temp2 would be the CPU temperature, and temp1 would
> be the motherboard temperature. temp3 is a bit too high to be realistic
> so I'd be tempted to claim that it's not wired.
>
> If you come up with a good configuration file for this motherboard,
> please send it back and we'll put it on the website.
>
>   


--------------000706010001020802050602
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Thanks for the clues!&nbsp; I will send a configuration when I get there.<br>
<br>
I agree with your note about combining drivers.&nbsp; That is exactly why I
was initially taking that path.&nbsp; Basically, the only differences
between the k8temp and new k10temp drivers are on the number of
thermistors and how the temperature is calculated.&nbsp; Since the probe for
CPUID is easy enough, I felt that there was benefit.&nbsp; That said, it was
easy enough to just have a k10temp as well - which is where I am now.<br>
<br>
Thanks again,<br>
<br>
Fred<br>
<br>
Jean Delvare wrote:
<blockquote cite="mid:20080419105842.7866bf59@hyperion.delvare"
 type="cite">
  <pre wrap="">Hi Fred,

On Fri, 18 Apr 2008 23:44:31 -0600, Fred R. Beck wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I've been tied up and just got back to this.  Thanks much for the 
"stripped down" version.  It looked much like my last attempt though I'd 
missed on some of the registers...  I think you are right, this is 
simple enough that there isn't much sense in combining the two drivers, 
so I'll scrap that...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The main decision factor for combining support for several chips in a
single driver or not is not how simple they are but how similar they
are to each other.

  </pre>
  <blockquote type="cite">
    <pre wrap="">(...)
So, running sensors now gives:

    # modprobe k8temp
    # sensors
    it8718-isa-0228
    Adapter: ISA adapter
    in0:       +1.07 V  (min =  +0.00 V, max =  +4.08 V)  
    in1:       +1.90 V  (min =  +0.00 V, max =  +4.08 V)  
    in2:       +3.38 V  (min =  +0.00 V, max =  +4.08 V)  
    in3:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
    in4:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)  
    in5:       +3.25 V  (min =  +0.00 V, max =  +4.08 V)  
    in6:       +4.08 V  (min =  +0.00 V, max =  +4.08 V)  
    in7:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)  
    in8:       +3.07 V
    fan1:     1859 RPM  (min =   10 RPM)                  
    fan2:        0 RPM  (min =    0 RPM)                  
    fan3:        0 RPM  (min =    0 RPM)                  
    fan5:        0 RPM  (min =    0 RPM)                  
    temp1:       +39 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor  
    temp2:       +41 C  (low  =  +127 C, high =   +70 C)   sensor = diode  
    temp3:       +84 C  (low  =  +127 C, high =  +127 C)   sensor = thermistor  
    vid:      +0.000 V

    k10temp-pci-00c3
    Adapter: PCI adapter

As you can see, I'm still figuring out how to configure lm_sensors for 
my GA-MA790FX-DS5...  However, temp1 looks ok and matches what I'm 
seeing in the BIOS.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Here's my guess for voltages if it helps you:
in0: Vcore
in1: Vram (although a bit high, should be 1.8)
in2: +3.3V
in3: +5V with scaling factor 1.68
in4: +12V with scaling factor 4
in5: 3VSB or 5VSB with a scaling factor of 1.68
in6: unused
in7: unused
in8: Vbat

Please check your logs after loading the it87 driver, it might give
hints about in3 and in7.

If your BIOS displays voltage values, compare with those to validate
your lm-sensors configuration settings.

As for temperature, temp2 would be the CPU temperature, and temp1 would
be the motherboard temperature. temp3 is a bit too high to be realistic
so I'd be tempted to claim that it's not wired.

If you come up with a good configuration file for this motherboard,
please send it back and we'll put it on the website.

  </pre>
</blockquote>
<br>
</body>
</html>

--------------000706010001020802050602--


--===============3313535229009495851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3313535229009495851==--
