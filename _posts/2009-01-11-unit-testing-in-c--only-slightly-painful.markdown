---
layout: post
title: Unit Testing in C - Only Slightly Painful
tags: [c, code, testing, strophe]
time: "23:00"
extended: ":EXTENDED:"
---

I have some new projects in mind that require native
[XMPP](http://www.xmpp.org) library, and I'm planning to use
[libstrophe](http://code.stanziq.com/strophe).  I wanted to update it
to support [XPath](http://www.w3.org/TR/xpath) matching for stanza
handlers, and I figured this would be a great time to inject some
tests into the code base.  After a bit of asking around, I decided to
give [Check](http://check.sourceforge.net) a try, and while unit
testing in C is not nearly as pleasant as Python or Ruby, I've found
it to be not too bad.

:EXTENDED:

Check is one of a number of C unit testing frameworks.  Even though
these frameworks exist, most of the C projects that I know of that do
unit testing use custom code.  [Git](http://git.or.cz) is a good
example using quite a bit of shell magic.  libstrophe did something
similar by just writing C files that returned 0 for pass and 1 for
fail.  

I wanted something a little nicer and less tedious, and Check seems to
fit the bill nicely.

Here is a new parser test for libstrophe which I wrote before I
refactored this module.

<code>
<pre name='code' class='c'>
/* check_parser.h
** strophe XMPP client library -- parser tests
** .. boilerplate snipped ...
*/

#include <stdlib.h>

#include <check.h>

#include <strophe.h>
#include "parser.h"

#include "test.h"

START_TEST(create_destroy)
{
    xmpp_ctx_t *ctx;
    parser_t *parser;

    ctx = xmpp_ctx_new(NULL, NULL);
    parser = parser_new(ctx, NULL, NULL, NULL, NULL);
    fail_unless(parser != NULL, "Parser creation failed.");
    parser_free(parser);
    xmpp_ctx_free(ctx);
}
END_TEST

int cbtest_got_start = 0;
void cbtest_handle_start(char *name, char **attrs, void *userdata)
{
    if (strcmp(name, "stream:stream") == 0)
        cbtest_got_start = 1;
}

int cbtest_got_end = 0;
void cbtest_handle_end(char *name, void *userdata)
{
    if (strcmp(name, "stream:stream") == 0)
        cbtest_got_end = 1;
}

int cbtest_got_stanza = 0;
void cbtest_handle_stanza(xmpp_stanza_t *stanza, void *userdata)
{
    if (strcmp(xmpp_stanza_get_name(stanza), "message") == 0)
        cbtest_got_stanza = 1;
}

START_TEST(callbacks)
{
    xmpp_ctx_t *ctx;
    parser_t *parser;
    int ret;

    ctx = xmpp_ctx_new(NULL, NULL);
    parser = parser_new(ctx, 
                        cbtest_handle_start, 
                        cbtest_handle_end,
                        cbtest_handle_stanza, NULL);

    ret = parser_feed(parser, "<stream:stream>", 15);
    ret = parser_feed(parser, "<message/>", 10);
    parser_feed(parser, "</stream:stream>", 16);

    fail_unless(cbtest_got_start == 1);
    fail_unless(cbtest_got_end == 1);
    fail_unless(cbtest_got_stanza == 1);

    parser_free(parser);
    xmpp_ctx_free(ctx);
}
END_TEST

Suite *parser_suite(void)
{
    Suite *s = suite_create("Parser");
    TCase *tc_core = tcase_create("Core");
    tcase_add_test(tc_core, create_destroy);
    tcase_add_test(tc_core, callbacks);
    suite_add_tcase(s, tc_core);
    return s;
}

TEST_MAIN

</pre>
</code>

The tests appear between `START_TEST` and `END_TEST`.   `parser_suite`
builds up a test suite from the individual tests.  Since the `main`
function is the same in every test file, I put this in `test.h`.  The
macro is shown below.

<code>
<pre name='code' class='c'>
#define TEST_MAIN \
    int main(int argc, char **argv) {\
      int num_failed;\
      Suite *s = parser_suite();\
      SRunner *sr = srunner_create(s);\
      srunner_run_all(sr, CK_NORMAL);\
      num_failed = srunner_ntests_failed(sr);\
      srunner_free(sr);\
      return (num_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;\
    }
</pre>
</code>

I'm looking forward to having more test coverage in libstrophe thanks
to Check.

This new test code along with the new parser module should be hitting
the tree tomorrow.  I didn't manage to accomplish quite what I wanted,
but I did get the code cleaned up and added the ability to use
[libxml2](http://www.xmlsoft.org) or
[Expat](http://expat.sourceforge.net) as the base XML parser.
