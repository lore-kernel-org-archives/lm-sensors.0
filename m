From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 19 Jan 2009 10:30:22 +0000
Subject: Re: [lm-sensors] Wiki changes
Message-Id: <20090119113022.4da7bbea@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090107154912.1ea91779@hyperion.delvare>
In-Reply-To: <20090107154912.1ea91779@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Jan 2009 21:11:27 +0100, Jean Delvare wrote:
> Well, ideally what I would like to have is a bugzilla-like approach
> where people can create their own account in exchange of a valid e-mail
> address. This would let us track who changes what. And I am not aware
> of any bugzilla system being affected by spam.
> 
> But if this is not possible, then any solution that will let anonymous
> users contribute to the wiki while not making authenticated user lives
> more complex and that is robust to spammers is fine with me.
> 
> At this point it's up to the trac system administrator to continue.
> Axel, what can you offer?

In the meantime, Mark, are you interested in a wiki account to
contribute your own configuration files and possibly others? If you
are, please send _me_ the output of:

htdigest -c $user-passwd lm-sensors/i2c $user

where $user is your desired login, and I'll create an account for you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
