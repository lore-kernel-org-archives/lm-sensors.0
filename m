From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: mandrake issues
Message-Id: <Pine.LNX.4.58.0406141702350.22103@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040614122901.4625.qmail@web80306.mail.yahoo.com>
In-Reply-To: <20040614122901.4625.qmail@web80306.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

Please would you be so kind and provide more information?

First. What kernel are you using ?
hint: uname -a

Second. For kernel 2.6 you need to compileonly userspace part of
lm_sensors package (make user; make user_install) There is maybe some
package for MDK ? Did you try ?

 You can visit us on IRC on irc.freenode.net channel #linux-sensors

Regards

Rudolf

On Mon, 14 Jun 2004, Jeffrey Mitchell wrote:

> I am trying to install lmsensors in Mandrake 10 and
> the make file runs without error. then when i run the
> "Make install", it returns errors of a kind i know
> nothing about. Is ther something i need to do that is
> specific to Mandrake 10, that will make it install
> correctly?
>
> Jeff
>
>
