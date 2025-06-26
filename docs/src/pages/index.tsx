import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import HomepageFeatures from '@site/src/components/HomepageFeatures';
import Heading from '@theme/Heading';
import Layout from '@theme/Layout';
import { Analytics } from "@vercel/analytics/react";
import clsx from 'clsx';
import type { ReactNode } from 'react';

import styles from './index.module.css';

function HomepageHeader() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <header className={clsx('hero', styles.heroBanner)}>
      <div className="container" style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        <Heading
          as="h1"
          className="hero__title"
          style={{
            display: 'flex',
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'center',
            textAlign: 'center',
          }}
        >
          <img src="/img/logo.svg" alt="Sarus Logo" height="60" style={{ marginRight: '0.5rem' }} />
          {siteConfig.title}
        </Heading>
        <p className="hero__subtitle" style={{ textAlign: 'center' }}>{siteConfig.tagline}</p>
        <div className={styles.buttons} style={{ display: 'flex', justifyContent: 'center' }}>
          <Link
            className="button button--primary button--lg"
            to="/docs/intro">
            Getting Start - 5min ⏱️
          </Link>
        </div>
      </div>
    </header>
  );
}

export default function Home(): ReactNode {
  // const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title="Sarus"
      description="Description will go into a meta tag in <head />">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
      <Analytics />
    </Layout>
  );
}
