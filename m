From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: bmcsensors and strange sensor values.
Message-Id: <41489193.8040700@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
In-Reply-To: <45A0FF82385BEB4C8670E255530B338527B4CE@mssydeb.asi.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Peter Wilsmore wrote:

>Hi,
>I'm still having problems with this bmcsensors module, only this time I get the right readings - when it works. I found from MSI whilst my values seemed high they were correct, so I now have conv_val looking like:
>
>static long conv_val(int value, struct sdrdata *sd)
>{
>  
>
>[snip]
>                if(sd->linear != 7)
>                        r /= exps[16 - k2];
>                else
>                {
>                        // 1 / x * 10 ** (-m) = 10 ** m / x
>                        temp = exps[16 - k2] / r;
>                        r = temp;
>                }
>        return r;
>}
>
>However if I have the stuff added for the nonlinear conversion then it will intermittently crash with:
>
>Call Trace: [<ffffffffa009c2f0>]{:bmcsensors:conv_val+112}
>       [<ffffffffa009ea70>]{:bmcsensors:sdrd+720} [<ffffffffa009e640>]{:bmcsensors:bmc_client+0}
>       [<ffffffffa009c41d>]{:bmcsensors:bmcsensors_all+173}
>       [<ffffffffa008f8b7>]{:i2c-proc:i2c_sysctl_real_Rsmp_86c8b883+151}
>       [<ffffffffa009e640>]{:bmcsensors:bmc_client+0} [<ffffffffa009c370>]{:bmcsensors:bmcsensors_all+0}
>       [<ffffffff801e88d6>]{do_con_trol+422} [<ffffffff801e9c65>]{do_con_write+1589}
>       [<ffffffff801ea270>]{con_write+32} [<ffffffff8012b760>]{do_sysctl_strategy+144}
>       [<ffffffff8012b44c>]{do_sysctl+140} [<ffffffff8012b4f3>]{sys_sysctl+90}
>       [<ffffffff80110177>]{system_call+119}
>
>Code:  48 f7 fb 48 89 c3 48 83 c4 08 48 89 d8 5b 5d 41 5d c3
>
>Kernel panic: Fatal exception
>
>The annoying thing is it will not happen every time, and if it works for the first few times after a reboot I can run the sensors command indefinitely without a crash, however if I restart the computer might crash the first time I run it. Anyone have any idea what I have stuffed up? I can send my ksym files if it will help.
>
>  
>

Could it be that you're dividing by zero?  You don't check the value of 
'r' before the division to be sure that it's not zero.  If there is a 
fan failure and the current fan speed is 0, then perhaps r is returned 
as 0 instead of it's max value.

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
