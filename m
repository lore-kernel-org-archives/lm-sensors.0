From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Aug 2007 17:17:34 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <20070821191734.560d99f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Tue, 21 Aug 2007 16:38:48 +0200, Axel Thimm wrote:
> Yes, there are some attempts at a trac specific solution, but I was
> thinking of a generic one, e.g. one that feeds an LDAP server and then
> trac/mediawiki/moin/apache/you_name_it can simply query the login
> credentials. That way this solution will be usable by far more than a
> trac instance.
> 
> The LDAP part is dealt with at CLI level. What is missing is the Web
> interface. I envision it as such:
> 
>  o User gives in data required, this would be Name (but split in
>    first/last), email & password. This is protected by a
>    (re)captcha. There is already a lib for PHP for recaptcha.
>  o The system stores a cookie and sends the authentication code to the
>    email specified (just like mailman)
>  o The user clicks on the web authentication URL and the web app calls
>    a cli app that creates the account
> 
> In our case the cli app will be pushing the credential data to an LDAP
> server, another implementation could use htdiegst files, /etc/passwd,
> (l)useradd etc.

This sounds more complex than a trac-driven project should need.

> It is not much different from what mailman does other than adding a
> captcha.

Do we really need a mail validation mechanism (as bugzilla and mailman
do) AND a captcha? I thought that we only needed one method. I've
always seen the captcha as a replacement for email validation when
email validation is considered too much. In the case of trac we want an
email address anyway (for ticket change notifications).


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
