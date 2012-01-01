#!/usr/bin/perl

; use Sub::Uplevel
; use strict
; use warnings
; package main

; use Test::More tests => 5

; BEGIN { use_ok( 'basis' ) }
########################################################
# Test with inline classes

; package My::Base

; sub import { $My::Base::v="i" }

SKIP: {
    package main;
    local $basis::base = $basis::base;
    BEGIN 
        { eval "require parent"
        ; skip("parent specific test",4) if $@
        ; $basis::base = 'parent'
        }
    ; package My::Shoe
    ; use basis -norequire => 'My::Base'

    ; package main
    ; ok(! My::Shoe->isa("Sub::Uplevel"))
    ; ok(! My::Shoe->isa("parent"))
    ; ok(My::Shoe->isa("My::Base") , "isa")
    ; is($My::Base::v , "i"        , "import call")
    }

