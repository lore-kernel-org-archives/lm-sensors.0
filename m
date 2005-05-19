From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: max1619
Message-Id: <20040521152544.560d8aa1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I alredy made an user-space. am i need to send you all changet files
> or am i need to have acsess to CVS ?

You would need to send a patch against CVS.

> About patch. Ok i do it but i dont know haw to do patch, im jast
> beginner. Your help are needet by me. 

OK...

Basically you need to have two trees on your system, one with the
original files, one with the original files + your changes. Once you
have that and have ensured that your changes are correct, move to the
upper directory and use "diff -ruN" to generate the patch.

Complete example:

Say that you want to submit a patch against Linux 2.6.6-mm4. First get
the Linux 2.6.6 tree and untar it somewhere. In this example, I'll
suppose that you will untar it in ~/work.

So you have ~/work/linux-2.6.6.

Now, get the 2.6.6-mm4.bz2 patch and apply it:
  cd ~/work/linux-2.6.6
  bzcat /path/to/2.6.6-mm4.bz2 | patch -p1

At this point, I suggest you rename the directory:
  cd ~/work
  mv linux-2.6.6 linux-2.6.6-mm4

Now, duplicate the tree:
  cd ~/work
  cp -a linux-2.6.6-mm4 linux-2.6.6-mm4-max1619

After that, you can do all the changes you need in
linux-2.6.6-mm4-max1619. Test that it works as intended. Then you can
generate a patch and send it to us:
  cd ~/work
  diff -ruN linux-2.6.6-mm4 linux-2.6.6-mm4-max1619 > linux-2.6.6-mm4-max1619.diff

Same for the CVS repository. Check it out, duplicate the tree, do your
changes, generate a patch, and send it to us.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
