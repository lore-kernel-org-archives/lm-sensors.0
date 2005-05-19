From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: today CVS compilation bug
Message-Id: <20031130132742.3a2a4ad6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1070192499.553.4.camel@newdeal>
In-Reply-To: <1070192499.553.4.camel@newdeal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Today CVS doesn't compile when running make user
> It loops forever
> 
> The problem is that some files have timestamp in the future
> 
> A touch of all the tree corrected the problem

That's right, looks like our CVS serve lives half an hour in the future.
Phil, could you please fix mordac's time?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
