From: Udo van den Heuvel <udovdh@xs4all.nl>
Date: Fri, 14 Dec 2007 15:33:17 +0000
Subject: Re: [lm-sensors] k8temp weirdness, it8716 questions
Message-Id: <4762A23D.30301@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <475FFF23.2070800@xs4all.nl>
In-Reply-To: <475FFF23.2070800@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>> If you come up with a good configuration file for that board, please
>>> submit it and we'll add it to our collection.
(...)
>>    label  temp2  "CPU Temp"
>>    label  temp1  "M/B Temp"
>>    ignore temp3
> 
> ... especially if you're going to ignore the sensor in question.

The jury is still out on temp3. (at least for me)
temp3 is closer to room temperature than temp. temp1 is (at idle) close
to CPU temp.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
