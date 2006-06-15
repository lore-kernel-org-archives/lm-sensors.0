From: sylvain@gomjabbar.ath.cx (Sylvain Jeaugey)
Date: Thu, 15 Jun 2006 15:20:05 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <Pine.LNX.4.62.0606151715320.3103@gomjabbar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 15 Jun 2006, David Hubbard wrote:
> I'm testing it on my system right now. I will let you know if there
> are problems.
Everything's OK here.

Manual fan control works fine.
David, is there anything else I should test ?
[ pwm2 is controling fan2. Other pwm don't have any effect (since the 
beginning). ]

Sylvain

> On 6/14/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
>> Hi all,
>>
>> Here is some updated version for the test. It fixes the stuff Jean found. I want
>> to read it once again I'm not falling asleep while reading it. It works for me
>> and I think it should work for you all too.
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

