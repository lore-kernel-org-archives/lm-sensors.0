From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Wed, 16 Jul 2008 15:44:02 +0000
Subject: Re: [lm-sensors] superio lock coordinator
Message-Id: <4dfa50520807160844v3df3e39ek461f01e3440e0e80@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <487C5810.3030205@gmail.com>
In-Reply-To: <487C5810.3030205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Wed, Jul 16, 2008 at 1:25 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> >> David,
>> >> do you have a preference wrt fn-ptr ? and if so, a single fn with 1 arg
>> >> :  0,1,2 for enter/exit/query ?
>> >> do you have any use for a flag bit ?  is there generality in it ?
>>
>> I think we could just use the same enter and exit sequences for
>> everything, and not make it customizable. Does that sound OK?
>
> No. We can have a universal exit sequence, but enter sequences are
> per-chip (or actually per chip family). That's even one part of the
> device identification (lets us differentiate between two chips with the
> same device ID register value.)

I think a fn-ptr would be fine. The function could take as an arg
enter/exit/query (0, 1, 2) and a pointer to a byte array with offset,
value, offset, value pairs. So I see the function having 3 args:

void (* fn-ptr)(int which, char * sequence, int sequence_max_length);

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
