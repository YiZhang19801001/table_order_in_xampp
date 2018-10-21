<?php

namespace Tests\Unit;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function testBasicTest()
    {
        // $this->browse(function ($browser) {
        //     $browser->visit('/home')
        //             -> assertSee('Latest Transactions');
        // });

        $this->get('/')->see('table');
    }
}
