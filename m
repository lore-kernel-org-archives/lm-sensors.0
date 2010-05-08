From: Sergey Kvachonok <ravenexp@gmail.com>
Date: Sat, 08 May 2010 18:19:10 +0000
Subject: Re: [lm-sensors] 3.1.2 sensord duplicate RRD name problem
Message-Id: <AANLkTikyzPpimyaQGguEpIDDbirIPjO2e4s5ha_wPC0-@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
In-Reply-To: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/6/10, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 6 May 2010 14:20:56 +0200, Jean Delvare wrote:
>> I have a patch ready, I'll give it some testing to make sure I got it
>> right, and then I'll post it here.
>
> Andre, can you please comment on the patch below? Sergey, any chance
> you could test it? It works for me on two different machines, but I may
> not have covered all possible cases.

smartd starts ok, RRD contains temp1 and temp1_0. Still no idea how to
tell which is which, but at least it starts and logs everything.

Thanks for your hard work,
Sergey

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
