From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: /proc/device-tree
Message-Id: <20030807123045.2482061b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030807121206.73a80468.khali@linux-fr.org>
In-Reply-To: <20030807121206.73a80468.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi Jean
> 
> Thanks for your Mail.
> 
> ls of my device-tree folder gives me:

Whaou, there are many files there. What I'd need is a copy of the whole
tree (because I don't know what I am looking for yet).

> Let me know what else you need.

Please "extract" the tree using the following commands:

cp -R /proc/device-tree /tmp
cd /tmp
tar zcvf device-tree-zeno.tar.gz device-tree

And send me the file device-tree-zeno.tar.gz (to me, not to the list).

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
