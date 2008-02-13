From: MillTek <mill.tek@verizon.net>
Date: Wed, 13 Feb 2008 15:23:52 +0000
Subject: Re: [lm-sensors] Kernel 2.6.24 and the F1882G chip
Message-Id: <47B30B88.3000308@verizon.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7363182010373680579=="
List-Id: <lm-sensors.vger.kernel.org>
References: <47B1C83C.2050703@verizon.net>
In-Reply-To: <47B1C83C.2050703@verizon.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============7363182010373680579==
Content-type: multipart/alternative;
	boundary=------------020000040101090603090304

This is a multi-part message in MIME format.
--------------020000040101090603090304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Jean. I'll try that and get back if it doesn't work out.

Jim

Jean Delvare wrote:
> Hi Jim,
>
> On Tue, 12 Feb 2008 11:39:35 -0600, MillTek wrote:
>   
>> I've just been told that I've screwed up by using the 'reply' button.  
>> Apparently this caused my initial posts to become threaded into other 
>> topics instead of starting a new on which can cause confusion. I 
>> apologize for that.
>>
>> Anyway, here's my problem;
>>
>> Kernel 2.6.24 for my distro (Arch Linux) came out in the last few days.
>> My board has a Fintek F1882g chip. It means that I can finally get
>>     
>
> I'll assume that you really mean "Fintek F71882FG".
>
>   
>> voltage and fan speeds for the board, so thanks for that.  I am
>> wondering how I correctly calculate the correct offset and factors for
>> the voltage numbers? This is what GKrellm says;
>>
>> Vcor1  1.66  factor 1 offset 0
>> Vcor2  1.24  factor 1 offset 0
>> +3.3v   2.83  factor 3  offset 0
>> +5v      4.82  factor 4.98 offset 0
>> +12v    3.84 factor 4.0  offset 0
>> -12v    -4.35  factor -4.0 offset 0
>> -5v      -1.51  factor -1.667 offset 0
>> in7      1.66    factor 1  offset 0
>> in8       1.54   factor 1 offset 0
>>
>> If there's a website that I should visit can anyone supply a link??
>>     
>
> No, there is no such "website". Each chip is different and each
> motherboard is different. Without technical documentation, you have to
> guess it all by yourself. You shouldn't trust gkrellm, in this
> particular case it is messing everything up completely as far as I can
> see. The default sensors.conf file says:
>
> # Voltage
>     label in0         "3.3V"
>     label in1         "Vcore"
>     (...)
>     label in7         "3VSB"
>     label in8         "Battery"
>
>
> # never change the in0, in7 and in8 compute, these are hardwired in the chip!
>     compute in0       (@ * 2), (@ / 2) 
>     (...)
>     compute in7       (@ * 2), (@ / 2)
>     compute in8       (@ * 2), (@ / 2)
>
> So at least these ones do not depend on your specific motherboard
> (those brand and model name you didn't tell us, BTW).
>
> For the remaining input voltages (in2, in3, in4, in5 and in6), you
> should take a look at what your BIOS prints, that's the best hint you
> can get. The F71882FG datasheet suggests a scaling factor of 5.26
> (actually 247/47) for +5V and 11.00 (220/20) for +12V. If the
> manufacturer followed these recommendations, the raw reading (that you
> get with "sensors -c /dev/null" of +12V should be around +1.090V and
> the raw reading of +5V should be around +0.951V. This might help you
> find out which is which. But again the best way is to compare with what
> the BIOS says.
>
>   


--------------020000040101090603090304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Thanks Jean. I'll try that and get back if it doesn't work out.<br>
<br>
Jim<br>
<br>
Jean Delvare wrote:
<blockquote cite="mid:20080213114505.5e55687b@hyperion.delvare"
 type="cite">
  <pre wrap="">Hi Jim,

On Tue, 12 Feb 2008 11:39:35 -0600, MillTek wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I've just been told that I've screwed up by using the 'reply' button.  
Apparently this caused my initial posts to become threaded into other 
topics instead of starting a new on which can cause confusion. I 
apologize for that.

Anyway, here's my problem;

Kernel 2.6.24 for my distro (Arch Linux) came out in the last few days.
My board has a Fintek F1882g chip. It means that I can finally get
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'll assume that you really mean "Fintek F71882FG".

  </pre>
  <blockquote type="cite">
    <pre wrap="">voltage and fan speeds for the board, so thanks for that.  I am
wondering how I correctly calculate the correct offset and factors for
the voltage numbers? This is what GKrellm says;

Vcor1  1.66  factor 1 offset 0
Vcor2  1.24  factor 1 offset 0
+3.3v   2.83  factor 3  offset 0
+5v      4.82  factor 4.98 offset 0
+12v    3.84 factor 4.0  offset 0
-12v    -4.35  factor -4.0 offset 0
-5v      -1.51  factor -1.667 offset 0
in7      1.66    factor 1  offset 0
in8       1.54   factor 1 offset 0

If there's a website that I should visit can anyone supply a link??
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No, there is no such "website". Each chip is different and each
motherboard is different. Without technical documentation, you have to
guess it all by yourself. You shouldn't trust gkrellm, in this
particular case it is messing everything up completely as far as I can
see. The default sensors.conf file says:

# Voltage
    label in0         "3.3V"
    label in1         "Vcore"
    (...)
    label in7         "3VSB"
    label in8         "Battery"


# never change the in0, in7 and in8 compute, these are hardwired in the chip!
    compute in0       (@ * 2), (@ / 2) 
    (...)
    compute in7       (@ * 2), (@ / 2)
    compute in8       (@ * 2), (@ / 2)

So at least these ones do not depend on your specific motherboard
(those brand and model name you didn't tell us, BTW).

For the remaining input voltages (in2, in3, in4, in5 and in6), you
should take a look at what your BIOS prints, that's the best hint you
can get. The F71882FG datasheet suggests a scaling factor of 5.26
(actually 247/47) for +5V and 11.00 (220/20) for +12V. If the
manufacturer followed these recommendations, the raw reading (that you
get with "sensors -c /dev/null" of +12V should be around +1.090V and
the raw reading of +5V should be around +0.951V. This might help you
find out which is which. But again the best way is to compare with what
the BIOS says.

  </pre>
</blockquote>
<br>
</body>
</html>

--------------020000040101090603090304--


--===============7363182010373680579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7363182010373680579==--
