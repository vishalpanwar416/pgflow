# PG Flow - Design System & UI Guidelines

## Table of Contents
1. [Design Philosophy](#design-philosophy)
2. [Color Palette](#color-palette)
3. [Typography](#typography)
4. [Spacing System](#spacing-system)
5. [Components](#components)
6. [Screen Flows](#screen-flows)
7. [Accessibility](#accessibility)
8. [Animations & Transitions](#animations--transitions)

## Design Philosophy

PG Flow is built on the principles of **clarity**, **efficiency**, and **accessibility**. The design system prioritizes:
- **Consistency**: Uniform components and patterns across all screens
- **Simplicity**: Intuitive interfaces with minimal cognitive load
- **Responsiveness**: Seamless experience across different device sizes
- **Accessibility**: WCAG 2.1 AA compliance for all users

## Color Palette

### Primary Colors
- `primary-500`: #4F46E5 (Indigo)
- `primary-400`: #6366F1
- `primary-300`: #818CF8

### Secondary Colors
- `secondary-500`: #10B981 (Emerald)
- `secondary-400`: #34D399
- `secondary-300`: #6EE7B7

### Neutral Colors
- `neutral-900`: #111827 (Dark Grey)
- `neutral-700`: #374151 (Medium Grey)
- `neutral-500`: #6B7280 (Grey)
- `neutral-300`: #D1D5DB (Light Grey)
- `neutral-100`: #F9FAFB (Off White)

### Semantic Colors
- `success-500`: #10B981 (Green)
- `warning-500`: #F59E0B (Amber)
- `error-500`: #EF4444 (Red)
- `info-500`: #3B82F6 (Blue)

## Typography

### Font Family
- **Primary Font**: Poppins (Google Fonts)
- **Fallback**: sans-serif

### Text Styles

#### Headings
- **H1**: 32px, Bold, Line height: 40px
- **H2**: 28px, SemiBold, Line height: 36px
- **H3**: 24px, SemiBold, Line height: 32px
- **H4**: 20px, SemiBold, Line height: 28px
- **H5**: 18px, SemiBold, Line height: 24px
- **H6**: 16px, SemiBold, Line height: 22px

#### Body Text
- **Large**: 18px, Regular, Line height: 28px
- **Medium**: 16px, Regular, Line height: 24px
- **Small**: 14px, Regular, Line height: 20px
- **XSmall**: 12px, Regular, Line height: 16px

## Spacing System

### Base Unit: 4px
- **xs**: 4px
- **sm**: 8px
- **md**: 16px
- **lg**: 24px
- **xl**: 32px
- **2xl**: 48px
- **3xl**: 64px

### Container Widths
- **Max Content Width**: 1200px
- **Sidebar Width**: 280px (expanded), 80px (collapsed)
- **Card Padding**: 16px (mobile), 24px (desktop)

## Components

### Buttons

#### Primary Button
- **Height**: 48px
- **Padding**: 16px 24px
- **Border Radius**: 8px
- **Text Style**: Button (16px, SemiBold)
- **States**: Default, Hover, Pressed, Disabled

#### Secondary Button
- **Height**: 48px
- **Padding**: 16px 24px
- **Border**: 1px solid `neutral-300`
- **Border Radius**: 8px
- **Text Style**: Button (16px, SemiBold)

### Cards
- **Border Radius**: 12px
- **Elevation**: 2 (Light Mode), 0 (Dark Mode)
- **Background**: White (Light Mode), `neutral-800` (Dark Mode)
- **Padding**: 16px (Mobile), 24px (Tablet/Desktop)

### Input Fields
- **Height**: 48px
- **Border Radius**: 8px
- **Border**: 1px solid `neutral-300`
- **Padding**: 12px 16px
- **Focus State**: 2px solid `primary-500`

## Screen Flows

### Authentication Flow
1. **Splash Screen**
   - Logo animation
   - App name
   - Version number

2. **Login Screen**
   - Email/Phone input
   - Password input
   - Forgot password link
   - Social login options
   - Sign up link

3. **Sign Up Screen**
   - Role selection (Owner/Tenant)
   - Personal information form
   - Terms & Conditions checkbox
   - Sign up button

### Owner Dashboard
1. **Overview**
   - Quick stats (Occupancy, Revenue, Pending Payments)
   - Recent activities
   - Quick actions

2. **PG Management**
   - List of PGs
   - Add new PG
   - Edit/Delete PG
   - View details

### Tenant Dashboard
1. **Home**
   - Rent due status
   - Upcoming payments
   - Quick actions
   - Notices

2. **Complaints**
   - Submit new complaint
   - Track status
   - History

## Accessibility

### Color Contrast
- Minimum contrast ratio of 4.5:1 for normal text
- Minimum contrast ratio of 3:1 for large text (18pt+)

### Touch Targets
- Minimum touch target size: 48x48px
- Minimum spacing between touch targets: 8px

### Screen Reader Support
- All interactive elements have proper labels
- All images have alt text
- Proper heading hierarchy

## Animations & Transitions

### Micro-interactions
- Button press: Scale down 95%
- Card hover: Elevation increase + slight scale
- Input focus: Border color transition

### Page Transitions
- **Push**: Slide from right to left
- **Pop**: Slide from left to right
- **Modal**: Fade in + scale up

### Loading States
- **Content Loading**: Skeleton screens
- **Button Loading**: Spinner + disabled state
- **Page Loading**: Full-screen loader

## Dark Mode

### Color Adjustments
- Background: `neutral-900`
- Surface: `neutral-800`
- On Surface: `neutral-100`
- Primary: Lighter shade for better visibility
- Reduced elevation for depth

### Component Adjustments
- Cards: Subtle border instead of shadow
- Inputs: Darker background with light border
- Buttons: Slightly brighter primary color

## Icons
- **Icon Set**: Material Icons
- **Size**: 24x24px (standard), 20x20px (small)
- **Color**: `neutral-700` (Light Mode), `neutral-300` (Dark Mode)

## Responsive Design

### Breakpoints
- **Mobile**: < 600px
- **Tablet**: 601px - 1024px
- **Desktop**: > 1024px

### Layout Adjustments
- **Mobile**: Single column, stacked navigation
- **Tablet**: Two-column layout with sidebar
- **Desktop**: Full layout with sidebar and content area
