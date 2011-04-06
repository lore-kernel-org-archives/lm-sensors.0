From: "D.B. Tsai" <dbtsai@stanford.edu>
Date: Wed, 06 Apr 2011 08:54:56 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <BANLkTikTj-O4b-LMmqMg+eok2rgGkNMa9g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi

Since Fintek F71808E seems to be quick closed to F71808A, I copy
everything related to 71808E into F71808A in the f71882fg.c. The code
can be compiled, but when I try to modprobe, I got the error message
"FATAL: Error inserting f71882fg
(/lib/modules/2.6.38-8-server/kernel/drivers/hwmon/f71882fg.ko):
Device or resource busy
"

Anything I should notice?

Sincerely,

D.B. Tsai    蔡東邦
Ph.D. Student
Department of Applied Physics
Stanford University
-----------------------------------
Web: http://www.dbtsai.com
Phone : +1-650-383-8392   (USA)
              +886-910-008-392 (Taiwan)



On Tue, Apr 5, 2011 at 11:54 PM, D.B. Tsai <dbtsai@stanford.edu> wrote:
> Hi guys
>
> I just got an interesting board, ECS HDC-I2 AMD E350. I'm gonna use it
> as my use server, but I found out that lm-sensors doesn't support it.
> The chip used by the board is Fintek F71808A. Will it be supported in
> the nearly future?
>
> Thank you.
>
> Sincerely,
>
> D.B. Tsai    蔡東邦
> Ph.D. Student
> Department of Applied Physics
> Stanford University
> -----------------------------------
> Web: http://www.dbtsai.com
> Phone : +1-650-383-8392   (USA)
>               +886-910-008-392 (Taiwan)
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
