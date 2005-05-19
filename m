From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: seperate mallocs
Message-Id: <20040417205221.51df2892.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <406E5CFB.6030309@penguincomputing.com>
In-Reply-To: <406E5CFB.6030309@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm not convinced by your argument, and I don't think I'm going to 
> change your mind, so I propose a comprimise.
> 
> Why not enclose the default: block with #ifdef DEBUG/#endif.  That
> way during driver development, we have the extra check and during
> "normal" runtime you don't have the overhead?

Solution #3:

I've commited a different fix which doesn't imply changes in error
paths, so I have no reason to change what you did and everyone's happy
;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
