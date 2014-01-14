From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Jan 2014 13:26:56 +0000
Subject: Re: [lm-sensors] Sensors shows only 8 of 10 cores on 4-Socket Intel(R) Xeon(R) CPU E7- 4850 machine
Message-Id: <20140114142656.7d8e887a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
In-Reply-To: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please also provide the output of:
$ strace sensors "coretemp-isa-0000"

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
