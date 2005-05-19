From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: back to life
Message-Id: <20021027223720.0c148138.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi everyone. I hope everybody's OK by now and that the incidents of
yesterday won't have too many consequences.

Phil, is it OK? I hope that your employer won't cause trouble because of
what happened.

I think that my theory of a loop caused by a mailbox quota exceeded is
right. I don't intend to blame anyone, this could happen, period. But
now we have to protect ourselves against the problem:

Two suggestions:

1* Discard messages from Mail Administrator etc.
2* Filter messages with size > say 50k. I checked all the legitimate
mails received on the list for the past 4 months and except two at
around 100k, they are all below 30k. Messages over the size limit should
be subject to manual acceptance.

Now I hope we'll be able to work on the project again. I have been
working on it these days and have some questions.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
